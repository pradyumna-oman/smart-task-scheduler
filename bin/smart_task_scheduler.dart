import 'dart:io';

Future<void> download(String fileType) async
{
  print('Downloading $fileType...');

  await Future.delayed(Duration(seconds: 5));

  print('$fileType Downloaded Successfully.');
}

void main() async
{
  print('Application started');
  
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
    await download("Image");
    break;
  case 2:
    await download("Video");
    break;
  case 3:
    await download("PDF");
    break;
  case 4:
    print("Thank you for using Smart Task Scheduler.");
    break;

  default:
    print('Invalid input');
}
  print('Application finished');
}
