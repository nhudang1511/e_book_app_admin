import 'package:flutter/material.dart';
import 'package:e_book_admin/model/models.dart';

class BookDetail extends StatefulWidget {
  const BookDetail(
      {super.key,
      required this.book,
      required this.categories,
      required this.listChapters,
      required this.listAuthors});

  final Book book;
  final List<Category> categories;
  final List<Chapters> listChapters;
  final List<Author> listAuthors;

  @override
  State<StatefulWidget> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  int currentStep = 1;
  late List<String> listCategories = [];
  late Chapters chapters;

  @override
  void initState() {
    super.initState();
    for (String categoryId in widget.book.categoryId) {
      String category = widget.categories
          .where((category) => category.id == categoryId)
          .first
          .name;
      listCategories.add(category);
      chapters = widget.listChapters
          .firstWhere((chapters) => chapters.bookId == widget.book.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    double dialogWidth = MediaQuery.of(context).size.width * 0.5;
    List<Widget> listShowChapters = [];
    List<String> sortedEntries = chapters.chapterList.keys.toList()
      ..sort((a, b) {
        int chapterNumberA = int.parse(a.replaceAll(RegExp(r'[^0-9]'), ''));
        int chapterNumberB = int.parse(b.replaceAll(RegExp(r'[^0-9]'), ''));
        return chapterNumberA.compareTo(chapterNumberB);
      });;

    for (String chapter in sortedEntries) {
      listShowChapters.add(
        Column(
          children: [
            Row(
              children: [
                Text('$chapter:'),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: SizedBox(
                                width: dialogWidth,
                                child: SingleChildScrollView(
                                    child:
                                        Text(chapters.chapterList[chapter]))),
                            actions: [
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
                            title: Text(
                              chapter,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          );
                        });
                  },
                  child: const Text(
                    'View Chapter',
                    style: TextStyle(color: Colors.white),
                  ),
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
                    const Text(
                      'Title: ',
                      style: TextStyle(color: Colors.white60),
                    ),
                    Text(widget.book.title)
                  ],
                ),
                const SizedBox(height: 8),
                // TextField cho Author
                Row(
                  children: [
                    const Text(
                      'Author: ',
                      style: TextStyle(color: Colors.white60),
                    ),
                    Text((widget.listAuthors
                        .firstWhere(
                          (author) => author.id == widget.book.authodId,
                          orElse: () => Author(widget.book.authodId, 'unknown',
                              true), // Default value or handle accordingly
                        )
                        .fullName!)),
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
                      const Text(
                        'Description: ',
                        style: TextStyle(color: Colors.white60),
                      ),
                      Expanded(child: Text(widget.book.description)),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // TextField cho Language
                Row(
                  children: [
                    const Text(
                      'Language: ',
                      style: TextStyle(color: Colors.white60),
                    ),
                    Text(widget.book.language),
                  ],
                ),
                const SizedBox(height: 8),

                // TextField cho Country
                Row(
                  children: [
                    const Text(
                      'Country: ',
                      style: TextStyle(color: Colors.white60),
                    ),
                    Text(widget.book.country),
                  ],
                ),

                const SizedBox(height: 8),
                // DropdownButton cho Category ID
                Row(
                  children: [
                    const Text(
                      'Category: ',
                      style: TextStyle(color: Colors.white60),
                    ),
                    Text(listCategories.join(', ')),
                  ],
                ),
                const SizedBox(height: 8),
                // TextField cho Chapters
                Row(
                  children: [
                    const Text(
                      'Chapters: ',
                      style: TextStyle(color: Colors.white60),
                    ),
                    Text(widget.book.chapters.toString()),
                  ],
                ),
                const SizedBox(height: 8),
                // TextField cho Image URL
                const Text(
                  'Image cover: ',
                  style: TextStyle(color: Colors.white60),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      widget.book.imageUrl,
                      width: 200,
                      height: 200,
                    ),
                  ],
                ),
                // TextField cho Book Preview
                const SizedBox(height: 8),
                // TextField cho Image URL
                const Text(
                  'Book Preview: ',
                  style: TextStyle(color: Colors.white60),
                ),
                const SizedBox(height: 4),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.network(
                      widget.book.bookPreview[0],
                      width: 350,
                      height: 350,
                    ),
                    Image.network(
                      widget.book.bookPreview[1],
                      width: 350,
                      height: 350,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
              ],
              if (currentStep == 2) ...listShowChapters,
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
      ],
    );
  }
}
