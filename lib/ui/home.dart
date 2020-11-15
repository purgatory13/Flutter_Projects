import 'package:first_flutter_app/model/movie.dart';
import 'package:first_flutter_app/model/question.dart';
import 'package:first_flutter_app/util/hexcolor.dart';
import 'package:flutter/material.dart';

class MovieListView extends StatelessWidget {

  final List<Movie> movieList = Movie.getMovies();

  final List movies = [
    "1984",
    "I am Legend",
    "A Clockwork Orange",
    "The Zero Theorem",
    "Snowpiercer",
    "Brazil",
    "Metropolis",
    "Soylent Green",
    "Bladerunner",
    "The Island",
    "District 9",
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Dystopian Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ), //Appbar
      backgroundColor: Colors.blueGrey.shade400,
      body: ListView.builder(
        itemCount: movieList.length,
          itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 4.5,
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              child: Container(
                width: 200,
                  height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    //image: NetworkImage(movieList[index].images[0]),
                    image: NetworkImage(movieList[index].poster),
                    fit: BoxFit.cover
                  ),
                  //color: Colors.blue,
                  borderRadius: BorderRadius.circular(13.9)
                ),
                child: null,
                //child: Text(""),
              ),
            ),
            trailing: Text("..."),
            title: Text(movieList[index].title),
            subtitle: Text("${movieList[0].title}"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => MovieListViewDetails(movieName: movieList.elementAt(index).title,
                  movie: movieList[index] )));
            },
            //onTap: () => debugPrint("Movie name: ${movies.elementAt(index)}"),
          ), //list Tile
        ); //Card
      }), //Listview.builder
    ); //scaffold
  }
}

//end of MovieListView
//new route/screen/page
class MovieListViewDetails extends StatelessWidget {

  final String movieName;
  final Movie movie;

  const MovieListViewDetails({Key key, this.movieName, this.movie}) : super(key: key);

  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies "),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: Center(
        child: Container(
          child: RaisedButton(
            child: Text("Go back ${this.movie.director}"),
            onPressed: (){
            Navigator.pop(context);
            }),
          ),
      ),
      );
  }
}



class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}


class _QuizAppState extends State<QuizApp> {
  int _currentQuestionIndex = 0;

  List questionBank = [
    Question.name(
        "The U.S. Declaration of Independence was adopted in 1776.", true),
    Question.name("The Supreme law of the land is the Constitution.", true),
    Question.name(
        "The two rights in the Declaration of Independence are:"
            "  \n Life  "
            "  \n Pursuit of happiness.",
        true),
    Question.name("The (U.S.) Constitution has 26 Amendments.", false),
    Question.name(
        "Freedom of religion means:\nYou can practice any religion, "
            "or not practice a religion.",
        true),
    Question.name("Journalist is one branch or part of the government.", false),
    Question.name("The Congress does not make federal laws.", false),
    Question.name("There are 100 U.S. Senators.", true),
    Question.name("We elect a U.S. Senator for 4 years.", false), //6
    Question.name("We elect a U.S. Representative for 2 years", true),
    Question.name(
        "A U.S. Senator represents all people of the United States", false),
    Question.name("We vote for President in January.", false),
    Question.name("Who vetoes bills is the President.", true),
    Question.name("The Constitution was written in 1787.", true),
    Question.name('George Bush is the \ " Father of Our Country " \.', false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("True Citizen"),
        centerTitle: true,
        // backgroundColor: Colors.blueGrey,
      ),

      // backgroundColor: Colors.blueGrey,

      // We use [Builder] here to use a [context] that is a descendant of [Scaffold]
      //or else [Scaffold.of] will return null
      body: Builder(
        builder: (BuildContext context) => Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Image.asset(
                  "images/flag.png",
                  width: 250,
                  height: 180,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(14.4),
                      border: Border.all(
                          color: Colors.blueGrey.shade400,
                          style: BorderStyle.solid)),
                  height: 120.0,
                  child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          questionBank[_currentQuestionIndex].questionText,
//                      style: TextStyle(fontSize: 16.9,
//                          color: Colors.white),
                        ),
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () => _prevQuestion(),
                    color: Colors.blueGrey.shade900,
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  RaisedButton(
                    onPressed: () => _checkAnswer(true, context),
                    color: Colors.blueGrey.shade900,
                    child: Text(
                      "TRUE",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () => _checkAnswer(false, context),
                    color: Colors.blueGrey.shade900,
                    child: Text(
                      "FALSE",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () => _nextQuestion(),
                    color: Colors.blueGrey.shade900,
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  _prevQuestion() {
    setState(() {
      _currentQuestionIndex = (_currentQuestionIndex - 1) % questionBank.length;
      debugPrint("Index: $_currentQuestionIndex");
    });
  }

  _checkAnswer(bool userChoice, BuildContext context) {
    if (userChoice == questionBank[_currentQuestionIndex].isCorrect) {
      //correct answer
      final snackbar = SnackBar(
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 500),
          content: Text("Correct!"));
      Scaffold.of(context).showSnackBar(snackbar);
      _updateQuestion();
    } else {
      debugPrint("Incorrect!");
      final snackbar = SnackBar(
          backgroundColor: Colors.redAccent,
          duration: Duration(milliseconds: 500),
          content: Text("Incorrect!"));
      Scaffold.of(context).showSnackBar(snackbar);

      _updateQuestion();
    }
  }

  _updateQuestion() {
    setState(() {
      _currentQuestionIndex = (_currentQuestionIndex + 1) % questionBank.length;
    });
  }

  _nextQuestion() {
    _updateQuestion();
  }
}
//end of BillSplitter

class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {

  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;

  Color _purple = HexColor("#6908D6");

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //main parent container
        body: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1) ,
          alignment: Alignment.center,
          color: Colors.white,
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(20.5),
            children: <Widget>[
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color:_purple.withOpacity(0.1),
                    //color: Colors.purpleAccent.shade100,
                  borderRadius: BorderRadius.circular(12.0)
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Total Per Person", style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                          color:_purple
                      ),),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("\$ ${calculateTotalPerPerson(_billAmount, _personCounter, _tipPercentage)}", style: TextStyle(
                          fontSize: 34.9,
                          fontWeight: FontWeight.bold,
                          color:_purple
                        ),),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:20.0),
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.blueGrey.shade100,
                    style: BorderStyle.solid
                  ),
                  borderRadius: BorderRadius.circular(12.0)
                ),
                child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: _purple),
                    decoration: InputDecoration(
                      prefixText: "Bill Amount",
                      prefixIcon: Icon(Icons.attach_money)
                    ),
                    onChanged: (String value) {
                      try {
    _billAmount = double.parse(value);

    }catch(exception) {
                        _billAmount = 0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Split", style: TextStyle(
                        color: Colors.grey.shade700
                      ),),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCounter > 1) {
                                _personCounter--;
                                }else {//do nothing
                                  }
                              });
                            },
                            child: Container(
                              width: 40.0,
                                height: 40.0,
                                margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: _purple.withOpacity(0.1)
                              ),
                              child: Center(
                                child: Text(
                                  "-", style: TextStyle(
                                  color: _purple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0
                                ),
                                ),
                              ),
                            ),
                          ),
                          Text("$_personCounter", style: TextStyle(
                            color: _purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0
                          ),),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _personCounter++;
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: _purple.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(7.0)
                              ),
                              child: Center(
                                child: Text ("+", style: TextStyle(
                                  color: _purple,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold
                                ),),
                              ),
                              )
                            ),
                          //wrong
                        ],
                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Tip", style: TextStyle(
                          color: Colors.grey.shade700
                      ),),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(" \$ ${ (calculateTotalTip(_billAmount,
                            _personCounter, _tipPercentage)).toStringAsFixed(2) }", style: TextStyle(
                          color: _purple,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0
                        ),),
                      )
                    ],
                  ),
                  //slider
                  Column(
                    children: <Widget>[
                      Text("$_tipPercentage%", style: TextStyle(
                        color: _purple,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold
                      ),),
                      Slider(
                        min: 0,
                        max: 100,
                        activeColor: _purple,
                        inactiveColor: Colors.grey,
                        divisions: 10,
                        value: _tipPercentage.toDouble(),
                        onChanged: (double newValue){
                        setState(() {
                          _tipPercentage = newValue.round();
                        });
                      },

                      ),
                    ],
                  )
                ],
                  )
                ),
            ],
          ),
        )
    );
  }
  calculateTotalPerPerson(double billAmount, int splitBy, int tipPercentage) {

    var totalPerPerson = (calculateTotalTip(billAmount, splitBy, tipPercentage) + billAmount) / splitBy;
    return totalPerPerson.toStringAsFixed(2);


  }
  calculateTotalTip(double billAmount, int splitBy, int tipPercentage) {
    double totalTip = 0.0;

    if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null) {
      //no go

    } else {
      totalTip = (billAmount * tipPercentage) / 100;
    }
    return totalTip;
  }
}
//end of billsplitter


//beginning of Quotes App
class Wisdom extends StatefulWidget {
  @override
  _WisdomState createState() => _WisdomState();
}

class _WisdomState extends State<Wisdom> {

  int _index = 0;
  List quotes = [
    "Life isn't about getting and having, it's about giving and being.",
    "Strive not to be a success, but rather to be of value.",
    "You miss 100% of the shots you do not take.",
    "Every strike brings me closer to the next home run.",
    "Write it on your heart that every day is the best day of the year. He is rich who owns the day and no one owns the day who allows it to be invaded with fret and anxiety. Finish every day and be done with it. You have done what you could. Some blunders and absurdities, no doubt crept in. Forget them as soon as you can, tomorrow is a new day; begin it well and serenely, with too high a spirit to be cumbered with your old nonsense. This day is too dear, with its hopes and invitations, to waste a moment on yesterdays.",
    "We become what we think about."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container (
        child: Column (
        mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
             child: Center (
            child: Container(
                  width: 350,
                  height: 200,
                  margin: EdgeInsets.all(30.0),
                  decoration:
                  BoxDecoration(
                      color: Colors.transparent,
                  borderRadius:BorderRadius.circular(14.5)
                  ),
                  child: Center(child: Text(quotes[_index % quotes.length],
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontStyle: FontStyle.italic,
                      fontSize: 16.5
                    ),
                  ))),
            ),
            ),


            Divider(thickness: 1.3,),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: FlatButton.icon(
                  onPressed: _showQuote,
                  color: Colors.greenAccent.shade700,
                  icon: Icon(Icons.wb_sunny),
                  label: Text("Inspire Me", style: TextStyle(
                    fontSize: 18.8,
                    color: Colors.white
                  ))),
            ),
            Spacer()//
          ],
        ),
      ),
    );
  }

  void _showQuote() {
//increment the index counter by 1 each time
  //need to set it as a state
    setState(() {
      _index += 1;
    });


  }
}


class BizCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BizCard"),
      ),
      backgroundColor: Colors.grey,

      body: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[

            _getCard(),
            _getAvatar(),

          ],
        ),
      ),
    );
  }

  Container _getCard() {
    return Container(
      width: 350,
      height: 200,
      margin: EdgeInsets.all(50.0),
      decoration: BoxDecoration(
        color: Colors.pinkAccent,
        borderRadius: BorderRadius.circular(15.5)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Monette Kollodge",
          style: TextStyle( fontSize: 20.9,
            color: Colors.white,
            fontWeight: FontWeight.bold),),
          Text("kollodgedesign.com"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.person_outline),
              Text("Twitter: @budster")
            ],
          )
        ],
      ),
    );

  }

  Container _getAvatar() {
    return Container(
      width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
          border: Border.all(color: Colors.redAccent, width: 1.2),
          image:DecorationImage(image: NetworkImage("https://picsum.photos/300/300"),
          fit: BoxFit.cover)
        ),
    );

  }
}

class ScaffoldExample extends StatelessWidget {

  _tapButton() {
    debugPrint("Tapped Button");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scaffold"),
        centerTitle: true,
        backgroundColor: Colors.grey.shade600,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.email),
              onPressed: () => debugPrint("email tapped")),
          IconButton(icon: Icon(Icons.map), onPressed: _tapButton)
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        child: Icon(Icons.call_missed),
        onPressed: () => debugPrint("Floating Action Button Pressed")),

      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text("First")),
        BottomNavigationBarItem(icon: Icon(Icons.ac_unit), title: Text("Second")),
        BottomNavigationBarItem(icon: Icon(Icons.access_alarm), title: Text("Third"))
      ], onTap: (int index) => debugPrint("Tapped item : $index"),),
      backgroundColor: Colors.redAccent.shade100,

      body: Container(
        alignment: Alignment.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
CustomButton()
              /*InkWell(
                child: Text("Tap me",
                  style: TextStyle(fontSize: 23.4),),

                onTap: () => debugPrint("tapped..."),

              )*/

            ]
        ),
      ),);
  }
}

class CustomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        final snackBar = SnackBar(content: Text("Hello Again!"),
        backgroundColor: Colors.pink.shade500,
        );
        Scaffold.of(context).showSnackBar(snackBar);
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
          color: Colors.pinkAccent,
          borderRadius: BorderRadius.circular(8.0)
      ),
        child: Text("Button"),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.tealAccent,
      child: Center(child: Container(child: Text(
        "Hello Monette", textDirection: TextDirection.ltr,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 23.4,
            fontStyle: FontStyle.normal
        ),))),
    );

    /*return Center(
      child: Text("Good Morning Monette", textDirection: TextDirection.ltr,),
    );
  }*/
  }
}

