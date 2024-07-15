import 'package:e_book_admin/items/items.dart';
import 'package:e_book_admin/repository/repositories.dart';
import 'package:e_book_admin/screen/admin/admin_books_screen/components/play_audio_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/widgets.dart';

class BookDetail extends StatefulWidget {
  const BookDetail({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<StatefulWidget> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  int currentStep = 1;
  late BookDetailItem? bookDetail;
  late BookRepository bookRepository = BookRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BookDetailItem?>(
      future: bookRepository.getBook(widget.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data != null) {
            bookDetail = snapshot.data;
            return formBookDetail(context);
          }
        }
        return const Loading();
      },
    );
  }

  Widget formBookDetail(BuildContext context) {
    double dialogWidth = MediaQuery.of(context).size.width * 0.5;
    List<Widget> listShowChapters = [];
    List<Widget> listShowAudios = [];
    //get chapter
    if (bookDetail?.listChapters != null) {
      List<String> sortedEntries = bookDetail!.listChapters!.chapterList.keys
          .toList()
        ..sort((a, b) {
          int chapterNumberA = int.parse(a.replaceAll(RegExp(r'[^0-9]'), ''));
          int chapterNumberB = int.parse(b.replaceAll(RegExp(r'[^0-9]'), ''));
          return chapterNumberA.compareTo(chapterNumberB);
        });
      for (String chapter in sortedEntries) {
        listShowChapters.add(
          Column(
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: SizedBox(
                                width: dialogWidth,
                                child: SingleChildScrollView(
                                  child: Text(
                                    bookDetail!
                                        .listChapters!.chapterList[chapter],
                                  ),
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Đóng Dialog
                                  },
                                  child: const Text(
                                    'Close',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                              title: Text(
                                chapter,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            );
                          });
                    },
                    child: const Text(
                      'View Chapter',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(chapter),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        );
      }
    }
    //get audio
    if (bookDetail?.listAudios != null) {
      List<String> sortedEntries = bookDetail!.listAudios!.chapterList.keys
          .toList()
        ..sort((a, b) {
          int chapterNumberA = int.parse(a.replaceAll(RegExp(r'[^0-9]'), ''));
          int chapterNumberB = int.parse(b.replaceAll(RegExp(r'[^0-9]'), ''));
          return chapterNumberA.compareTo(chapterNumberB);
        });
      for (String chapter in sortedEntries) {
        listShowAudios.add(
          Column(
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AudioPlayerDialog(
                              chapterTitle: chapter,
                              audioUrl:
                                  bookDetail!.listAudios!.chapterList[chapter],
                            );
                          });
                    },
                    child: const Text(
                      'Listen Audio',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(chapter),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        );
      }
    }
    return AlertDialog(
      title: const Text(
        'Book detail',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      content: SizedBox(
        width: dialogWidth,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (currentStep == 1) ...[
                // TextField cho Title
                Row(
                  children: [
                    Text(
                      'Title: ',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      bookDetail!.title,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // TextField cho Author
                Row(
                  children: [
                    Text(
                      'Author: ',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(bookDetail!.author.fullName!),
                  ],
                ),
                const SizedBox(height: 8),

                // TextField cho Description
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: dialogWidth,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description: ',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Expanded(child: Text(bookDetail!.description)),
                    ],
                  ),
                ),
                // TextField cho price

                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Price: ',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      bookDetail!.price.toString(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // TextField cho Language
                Row(
                  children: [
                    Text(
                      'Language: ',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(bookDetail!.language),
                  ],
                ),
                const SizedBox(height: 8),

                // TextField cho Country
                Row(
                  children: [
                    Text(
                      'Country: ',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(bookDetail!.country),
                  ],
                ),

                const SizedBox(height: 8),
                // DropdownButton cho Category ID
                Row(
                  children: [
                    Text(
                      'Category: ',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(bookDetail!.categories
                        .map((category) => category.name)
                        .join(', ')),
                  ],
                ),
                const SizedBox(height: 8),
                // TextField cho Image URL
                Text(
                  'Image cover: ',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      bookDetail!.imageUrl,
                      width: 200,
                      height: 200,
                    ),
                  ],
                ),
                // TextField cho Book Preview
                const SizedBox(height: 8),
                // TextField cho Image URL
                if (bookDetail!.bookPreview[0] != "") ...[
                  Text(
                    'Book review: ',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.network(
                        bookDetail!.bookPreview[0],
                        width: 350,
                        height: 350,
                      ),
                      Image.network(
                        bookDetail!.bookPreview[1],
                        width: 350,
                        height: 350,
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 4),
              ],
              if (currentStep == 2) ...listShowChapters,
              if (currentStep == 3) ...listShowAudios,
            ],
          ),
        ),
      ),
      actions: [
        if (currentStep == 1) ...[
          // Button to move to step 2
          // button cancel
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng Dialog
            },
            child: const Text(
              'Close',
              style: TextStyle(color: Colors.white),
            ),
          ),
          // button next
          if (listShowChapters.isNotEmpty) ...[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  currentStep = 2;
                });
              },
              child: const Text(
                'List chapters',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
          if (listShowAudios.isNotEmpty) ...[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  currentStep = 3;
                });
              },
              child: const Text(
                'List Audios',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ],
        if (currentStep == 2) ...[
          // button cancel
          ElevatedButton(
            onPressed: () {
              setState(() {
                currentStep = 1;
              });
            },
            child: const Text(
              'Book Information',
              style: TextStyle(color: Colors.white),
            ),
          ),
          // button next
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng Dialog
            },
            child: const Text(
              'Close',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        if (currentStep == 3) ...[
          // button cancel
          ElevatedButton(
            onPressed: () {
              setState(() {
                currentStep = 1;
              });
            },
            child: const Text(
              'Book Information',
              style: TextStyle(color: Colors.white),
            ),
          ),
          // button next
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng Dialog
            },
            child: const Text(
              'Close',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ],
    );
  }
}
