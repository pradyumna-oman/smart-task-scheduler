import 'dart:io';

Future<void> download(String fileType, int seconds) async
{
  print('Downloading $fileType...');
  print('Estimated time: $seconds seconds');
  print('\n');
  await Future.delayed(Duration(seconds: seconds));

  print('$fileType Downloaded Successfully.');
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

  int choice = int.parse(stdin.readLineSync() ?? '0');

  switch(choice)
  {
    case 1:
      await download("Image",2);
      break;
    case 2:
      await download("Video",8);
      break;
    case 3:
      await download("PDF",4);
      break;
    case 4:
      print("Thank you for using Smart Task Scheduler.");
      isRunning = false;
      break;

    default:
      print('Invalid input');
  }
}while(isRunning);

print('Application finished');
}
