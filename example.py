# *********************************************************************************************************************
# mvn_watchdog.py:  This module contains the WatchdogThread and MVNTakesHandler classes. These classes are used to
# monitor the MVN takes directory for new files and create tasks when a '.mvr' file is deleted. The task is then added
# to a task queue and a signal is emitted to update_elements the task model in the main application.
# *********************************************************************************************************************
import queue
from pathlib import Path

from Qt.QtCore import QObject, Signal, Slot
from spearhead.reprocessor.tasks import ReprocessorTask
from spearhead.shared.utils import Counter
from watchdog.events import FileSystemEventHandler
from watchdog.observers import Observer


# ======================================================================================================================
class WatchdogThread(QObject):
    SIG_task_created = Signal(object)

    def __init__(
        self,
        mvn_installation_directory: Path,
        takes_directory: Path,
        output_directory: Path,
        task_queue: queue.Queue,
        queue_counter: Counter,
        time_start_zero: bool,
        reset_position: bool,
    ):
        super(WatchdogThread, self).__init__(parent=None)
        self.mvn_installation_directory = mvn_installation_directory
        self.takes_directory = takes_directory
        self.output_directory = output_directory
        self.task_queue = task_queue
        self.queue_counter = queue_counter
        self.time_start_zero = time_start_zero
        self.reset_position = reset_position
        self.observer = None

        self.keep_running = True

    @Slot()
    def start_mvn_watchdog(self):
        print(
            "notice: Starting Watchdog Observer. \
            Watching MVN takes directory for new takes..."
        )
        try:
            output_directory = Path(self.output_directory)
            output_directory.mkdir(exist_ok=True)

            event_handler = MVNTakesHandler(
                self.mvn_installation_directory,
                self.output_directory,
                self.task_queue,
                self.queue_counter,
                self.time_start_zero,
                self.reset_position,
                self.SIG_task_created.emit,
            )

            self.observer = Observer()
            self.observer.schedule(
                event_handler, str(self.takes_directory), recursive=False
            )
            self.observer.start()
        except Exception as e:
            print(f"Error: Could not start MVN Watchdog: {e}")

    def stop(self):
        print("Result: Stopping Watchdog Observer.")
        if self.observer:
            self.observer.stop()
            self.observer.join()


# ======================================================================================================================
class MVNTakesHandler(FileSystemEventHandler):
    def __init__(
        self,
        mvn_installation_directory: Path,
        output_directory: Path,
        task_queue: queue.Queue,
        queue_counter: Counter,
        time_start: bool,
        reset_position: bool,
        emit_task_created_signal: Signal,
    ):
        super().__init__()

        self.output_directory = output_directory
        self.mvn_installation_directory = mvn_installation_directory
        self.task_queue = task_queue
        self.queue_counter = queue_counter
        self.time_start = time_start
        self.reset_position = reset_position
        self.emit_task_created_signal = emit_task_created_signal

    def on_deleted(self, event):
        if not event.is_directory and event.src_path.endswith(".mvr"):
            task = ReprocessorTask(
                input_file_path=Path(event.src_path),
                mvn_installation_path=self.mvn_installation_directory,
                mvn_output_path=self.output_directory,
                time_start_at_zero=self.time_start,
                reset_position=self.reset_position,
            )

        try:
            print(f"Task created for {task.task_name}")
            self.task_queue.put(task)
            self.queue_counter.increment()
            self.emit_task_created_signal(task)

        except Exception as e:
            print(f"Error handling deleted file event: {e}")


# *********************************************************************************************************************

