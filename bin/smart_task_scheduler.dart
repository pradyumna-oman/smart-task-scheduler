import 'dart:io';

class Download
{
  String fileType;
  int seconds;
  String status;
  String date;
  String time;

  Download(this.fileType, this.seconds)
    : status = "Completed",
      date = "",
      time = ""
  {

    DateTime now = DateTime.now();

    date = '${now.day}/${now.month}/${now.year}';
    time = '${now.hour}:${now.minute}:${now.second}';
  }

  @override
  String toString()
  {
    return '$fileType | $status | $date | $time';
  }
}
  Future<void> download(String fileType, int seconds, List<Download> history) async
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
    Download download = Download(fileType, seconds);
    history.add(download);
  }

  bool validateChoices(List<String> choices)
  {
    for (String item in choices)
    {
      if(item.trim().isEmpty)
      {
        print("Empty values are not allowed.");
        print('Example: 1,2,3\n');
        return false;
      }
    }
    
    if(choices.contains("4") && choices.length > 1)
    {
      print('Exit cannot be combined with download options.\n');
      return false;
    }
  
    for(int i = 0; i < choices.length; i++)
    {
      int? choice = int.tryParse(choices[i].trim());
      if(choice == null || choice < 1 || choice > 5)
      {
        print('Invalid input. Please enter numbers between 1 and 5.');
        return false;
      }
    }
    return true;
  }

  void main() async
  {
  print('\nApplication started\n');
  bool isRunning = true;
  List<Download> history = [];
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
5. View Download History

Examples:
Single:   2
Multiple: 1,2,3

Enter your choice:''');

    String input = stdin.readLineSync() ?? "";
    if(input.trim().isEmpty)
    {
      print("Input cannot be empty.\n");
      continue;
    }
    List<String> choices = input.split(",");
    
    List<Future<void>> downloads = [];

    if(!validateChoices(choices)) 
    {
      continue;
    }

    for(int i = 0; i < choices.length; i++)
    {
      int? choice = int.tryParse(choices[i].trim());

        switch(choice)
      {
        case 1:
          downloads.add(download("Image",2,history));
          break;
        case 2:
          downloads.add(download("Video",8,history));
          break;
        case 3:
          downloads.add(download("PDF",4,history));
          break;
        case 4:
          print("Thank you for using Smart Task Scheduler.");
          isRunning = false;
          break;
        case 5:
          if(history.isEmpty)
          {
            print('========== Download History ==========');
            print('No downloads yet.');
            print('======================================');
          }
          else 
          {
            print('========== Download History ==========');
            for(int i = 0; i < history.length; i++)
            {
              print('${i + 1}. ${history[i]}'); 
            }
            print('======================================');
          }
          break;

        default:
          print('Invalid input\n');
      }
    }
    await Future.wait(downloads);
  }while(isRunning);

  print('Application finished');
}
