  import 'dart:io';

  Future<void> download(String fileType, int seconds) async
  {
    int milliSeconds = (seconds * 1000) ~/ 5;
    print('Downloading $fileType...');
    print('Estimated time: $seconds seconds\n');
    for(int progress = 20; progress <= 100; progress += 20)
    {
      int filled = progress ~/ 5;
      String bar = "";
      int remaining = 20 - filled;
      String dash = "";
      for(int i = 0; i < filled; i++)
      {
        bar = bar + "#";
      }
      for(int i = 0; i < remaining; i++)
      {
        dash = dash + "-";
      }
      await Future.delayed(Duration(milliseconds: milliSeconds));
      print('[$bar$dash] $progress% $fileType');
    }
    print("");
    print('$fileType Downloaded Successfully.\n');
  }

  void main() async
  {
  print('\nApplication started\n');
  bool isRunning = true;
  do
  { 
    print('''
==============================
    Smart Task Scheduler
==============================

1. Download Image
2. Download Video
3. Download PDF
4. Exit

Enter your choice:''');

    String input = stdin.readLineSync() ?? "";
    List<String> choices = input.split(",");
    List<Future<void>> downloads = [];

    if(choices.contains("4") && choices.length > 1)
    {
      print('Exit cannot be combined with download options.\n');
      continue;
    }

    for(int i = 0; i < choices.length; i++)
    {
      int choice = int.parse(choices[i].trim());

        switch(choice)
      {
        case 1:
          downloads.add(download("Image",2));
          break;
        case 2:
          downloads.add(download("Video",8));
          break;
        case 3:
          downloads.add(download("PDF",4));
          break;
        case 4:
          print("Thank you for using Smart Task Scheduler.");
          isRunning = false;
          break;

        default:
          print('Invalid input');
      }
    }
    await Future.wait(downloads);
  }while(isRunning);

  print('Application finished');
}
