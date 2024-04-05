# Starting With Cubit
## Final Goal: To learn Bloc

[![N|Cubit](https://miro.medium.com/v2/resize:fit:1400/1*zNjaXxPMRi9wxECUE6Pbng.png)]()


As i am searching for a job i found out that most companies uses either Getx or Blocs.
and while Seaching i found that someone Works at a company i want it to join he is using Bloc  So i figure out that is time to Switch from Riverpod to Bloc to Get a job.

so I decided to
- Found a Good Tuto
- Expriement with Blocs
- ✨Teach it✨

## Then what did i Learn
[From the Start][df1],talk about the Blocs and cubit differences , and i think i cannot speak about the differences until i use both of them very well.

but i will take you with me in some Details would be helpful for you as flutter Developer it could be minor things involved but since i included it I believe it's crutial to know

> The application to build is When button Pressed , some rondom names will appears on the screens

So I started by importing math  like this:

```sh
import 'dart:math' as math show Random;
```

and the way i can use it : 
```sh
math.Random().NextInt(9)
```
> as: is for me to use it to make a scope called "math" for all global function or variable in the package
>show: will only import the desired function from the library
> in our exemple : i imported only Random from math '

Next i created an extension to help me give a random Name from a list of Names.
```sh
extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}
```
- [RandomElemnt<T>] - Class Name that include all functionality related to an iterable<T>
- [getRandomElement] - The function available for Iterable<T>

For exemple let's say i have :
-- const names = [ 'John', 'Doe','b',  'd',];
i will use it like this :
-- names.getRandomElement()



This text you see here is *actually- written in Markdown! To get a feel
for Markdown's syntax, type some text into the left window and
watch the results in the right.

## Where is my business Logic
okay now we will talk about implimenting the logic of our app, and it should be in the cubit

```sh
class NamesCubit extends Cubit<String?> {
  NamesCubit() : super(null);

  void pickRandomName() {
    emit(names.getRandomElement());
  }
}
```
NamesCubit is a class that will take only one name of the list and in order to use it we first need to 
- decalare it
```sh
late final NamesCubit cubit;
```
- initialise it 

```sh
@override
  void initState() {
    cubit = NamesCubit();
    super.initState();
  }
```
ofcourse don't forget to dispose it



## Let's use what we prepared:
I start by using the function pickRandomName
```sh
floatingActionButton: FloatingActionButton(

             onPressed: cubit.pickRandomName,
            
or this way  //onPressed: () {
            //  cubit.pickRandomName();
            //},
           
          ),
```

then let's get our output: 

```sh
body: StreamBuilder(
          stream: cubit.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Random Name:',
                    ),
                    Text(
                      '${snapshot.data}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              );
            } else
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
          },
        ),
```


