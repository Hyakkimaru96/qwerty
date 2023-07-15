import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: SuccessStoryPage(),
  ));
}

class SuccessStoryPage extends StatefulWidget {
  @override
  _SuccessStoryPageState createState() => _SuccessStoryPageState();
}

class _SuccessStoryPageState extends State<SuccessStoryPage> {
  TextEditingController _storyController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _partnerNameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();

  List<SuccessStory> successStories = [];

  void _submitSuccessStory() {
    // Handle success story submission logic here
    String successStory = _storyController.text;
    String amount = _amountController.text;
    String partnerNames = _partnerNameController.text;
    String mobile = _mobileController.text;

    // Create a SuccessStory object
    SuccessStory newStory = SuccessStory(
      successStory: successStory,
      amount: amount,
      partnerNames: partnerNames,
      mobile: mobile,
    );

    setState(() {
      // Add the new story to the list
      successStories.add(newStory);
    });

    // Reset input fields
    _storyController.clear();
    _amountController.clear();
    _partnerNameController.clear();
    _mobileController.clear();

    // Navigate to the DisplaySuccessStoryPage and pass the successStories list
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisplaySuccessStoryPage(successStories),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Success Story'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              TextFormField(
                controller: _storyController,
                decoration: InputDecoration(
                  labelText: 'Success Story',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount of Business (INR)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _partnerNameController,
                decoration: InputDecoration(
                  labelText: 'Collaborating SIT Partner/s',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Mobile',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitSuccessStory,
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DisplaySuccessStoryPage extends StatelessWidget {
  final List<SuccessStory> successStories;

  DisplaySuccessStoryPage(this.successStories);

  void _deleteSuccessStory(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Story'),
          content: Text('Are you sure you want to delete this story?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                successStories.removeAt(index); // Remove the story at the specified index
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success Story Details'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(successStories.length, (index) {
                SuccessStory successStory = successStories[index];
                return Container(
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.only(bottom: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              successStory.successStory,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteSuccessStory(context, index),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        successStory.amount,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          Icon(Icons.people),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Partner Names:',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  successStory.partnerNames,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          Icon(Icons.phone),
                          SizedBox(width: 8.0),
                          Text(
                            successStory.mobile,
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class SuccessStory {
  final String successStory;
  final String amount;
  final String partnerNames;
  final String mobile;

  SuccessStory({
    required this.successStory,
    required this.amount,
    required this.partnerNames,
    required this.mobile,
  });

  factory SuccessStory.fromJson(Map<String, dynamic> json) {
    return SuccessStory(
      successStory: json['successStory'],
      amount: json['amount'],
      partnerNames: json['partnerNames'],
      mobile: json['mobile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'successStory': successStory,
      'amount': amount,
      'partnerNames': partnerNames,
      'mobile': mobile,
    };
  }
}

class SearchPage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search User'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Enter a user to search for',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String searchTerm = _searchController.text;
                // TODO: Implement search logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchResultPage(searchTerm),
                  ),
                );
              },
              child: Text('Search'),
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchResultPage extends StatelessWidget {
  final String searchTerm;

  SearchResultPage(this.searchTerm);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          'User not found',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
