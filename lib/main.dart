import 'package:flutter/material.dart';
import 'package:flutter_api_send_recieve/data.dart';

void main() {
  getStudents();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          inputDecorationTheme:
              InputDecorationTheme(border: OutlineInputBorder()),
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
              .copyWith(secondary: const Color(0xff16e5a7))),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Android Expert'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => _AddStudentForm(),
                ),
              );
              setState(() {});
            },
            label: Row(
              children: const [
                Icon(Icons.add),
                Text('Add Student'),
              ],
            )),
        body: FutureBuilder<List<StudentData>>(
          future: getStudents(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot != null) {
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 84),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return _Student(
                    studentdata: snapshot.data![index],
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

class _AddStudentForm extends StatelessWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _scoreController = TextEditingController();

  _AddStudentForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Student'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            try {
              final newStudentDat = await saveStudent(
                  _firstNameController.text,
                  _lastNameController.text,
                  _courseController.text,
                  int.parse(_scoreController.text));
              Navigator.pop(context, newStudentDat);
            } catch (e) {
              print(e.toString());
            }
          },
          label: Row(
            children: const [Icon(Icons.check), Text('Save')],
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                label: Text('First Name'),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                label: Text('Last Name'),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: _courseController,
              decoration: InputDecoration(
                label: Text('Course'),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _scoreController,
              decoration: InputDecoration(
                label: Text('Score'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Student extends StatelessWidget {
  final StudentData studentdata;
  const _Student({Key? key, required this.studentdata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.05))
          ]),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: 64,
            height: 64,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1)),
            child: Text(
              studentdata.firstName.characters.first,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w900,
                  fontSize: 24),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(studentdata.firstName + ' ' + studentdata.lastName),
                SizedBox(
                  height: 8,
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.grey.shade200),
                    child: Text(
                      studentdata.course,
                      style: TextStyle(fontSize: 10),
                    ))
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.bar_chart_rounded,
                color: Colors.grey.shade400,
              ),
              Text(
                studentdata.score.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}
