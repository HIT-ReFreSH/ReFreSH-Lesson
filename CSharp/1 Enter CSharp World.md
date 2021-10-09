# 第1讲 进入C#的世界

## 引言

大家好，从现在开始，我们来学习C\#。首先我们会议一下我们在课上学习过的C语言，很痛苦是不是，指针之类难懂的词汇历历在目。C\#语言在语法结构方面与C#相似，比如每个语句的结尾需要使用分号，while、for、if等循环条件语句的语法是一样的，函数的定义语法也是一样的。但是C\#语言要远比C语言容易上手，下面我就带大家了解一下，顺便复习一下一些C语言的知识。

## Hello World!

首先我们新建一个C#的控制台应用程序，我们可以看到创建的工程里的代码是这样的：

``` csharp
using System;

namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
        }
    }
}
```

我们先按照C语言的思维尝试理解这段代码，并且忽略所有看不懂的地方，如`using`、`namespace`、`class`，这些内容之后会讲。

我们可以看到一个名字为`Main`的函数。在C\#中，主函数的首字母大写，且默认返回类型为`void`，这两点与C语言不同。

同时，我们发现主函数里调用了一个叫做`Console.WriteLine`的函数，这个函数的作用是在控制台里输出，与C语言的`printf`类似。

这样，我们就能理解这个程序的作用了，即在控制台中输出`Hello World!`。

我们点击Visual Studio上面的绿色箭头按钮，或者按快捷键F5，就可以运行这个程序。我们可以看到，这段程序果然在控制台中输出了`Hello World!`。

## 变量声明

在成功输出`Hello World!`之后，恭喜你，你成功地进入了C\#的世界，并且完成了你人生中的第一个C\#程序，按照C语言的套路，我们现在应该读入两个数字，然后将其相加，并将其结果输出。当然，这在C\#中也是很容易做到的。

在C\#中，变量声明的方式与C语言相同，使用变量类型加上变量名就可以声明变量了。

我们来看下面几个例子：

``` csharp
int a;
```

声明一个名字为`a`的类型为`int`的变量。

``` csharp
int a, b;
```

声明两个名字分别为`a`、`b`的类型为`int`的变量。

``` csharp
double b;
```

声明一个名字为`b`的类型为`double`的变量。

``` csharp
int a = 1;
```

声明一个名字为`a`的类型为`int`的变量，并将其初值设为`1`。

我们可以发现，C\#声明变量的方式与C语言类相同，并且也有`int`和`double`两种与C语言相同名称的类型。

特别地，C\#支持使用`var`进行自动类型推导变量声明，会自动推测你声明变量的类型，但是必须为变量提供初值。

``` csharp
var a = 0; //自动推测a为int类型
var b = 1.0; //自动推测b为double类型
var c = 0, d = 1.0; //不合法，因为自动类型推导不能同时声明多个变量
var e; //不合法，自动类型推导声明变量必须有初值
```

> 使用自动类型推导的有益的，因为大部分类型的名称远远超过了三个字母，且大部分时候我们给变量的初值的类型是明确的。使用`var`能够极大地减少代码的输入量，并且能够使代码保持整洁清爽。但是在初学阶段，我们依然可以使用传统的变量声明方法来熟悉语言。


计算机只能处理数字，也就是说我们所有在计算机上储存的数据最终都是以数字的形式储存的。

在C语言中，引号之间的内容表示一串连续的字符，即字符串。在C语言中，没有特定的字符串类型，字符串使用`char`数组或者指向`char`的指针表示。

在C\#中，有一个特殊的类型`string`来表示字符串，你无需关心字符串是怎么储存的，也不用担心其结尾是否是`\0`，从控制台中读取的时候也不需要一个比较大的数组来储存，只需要使用：

``` csharp
string input = Console.ReadLine();
```

`Console.ReadLine`这个函数，就能从控制台中读取一行，并且返回一个字符串。我们可以直接获得原始输入。

## 类型转换

那么我们怎么把得到的string变成数字，完成我们前面的功能呢？
C#由一些库函数可以帮助我们进行类型转换。

``` csharp
string s = "10";
double d = 10.5;
int a = Convert.ToInt32(s); //合法，a的值是10
int b = Convert.ToInt32(d); //合法，b的值也是10，向下取整
```

函数`Convert.ToInt32`能够将大部分自带类型转换为32位整型，比如上面的`string`和`double`都能通过这种方式转化为整型。
## 完成加法程序

有了前面的知识，应该就能很容易完成输入两个数然后输出相加结果的程序了！

> 提示：C\#中的四则运算、逻辑运算、位运算的运算顺序、符号、法则与C语言基本相同，因此无需担心。

参考答案：

``` csharp
using System;

namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Input two numbers:");
            int a = Convert.ToInt32(Console.ReadLine());
            int b = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine(a + b);
        }
    }
}
```

运行结果：

``` text
Input two numbers:
2
3
5
```

## 进一步了解字符串

我们上面的加法程序有个很大的缺点，就是他直接输出了`a + b`的值，并没有告诉用户`a + b`的值是什么，我们这时候就需要进一步了解`string`了。

`string`类型可以使用加法操作，如：

``` csharp
string a = "abc" + "efg"; //结果为"abcefg"
string b = "1" + "1"; //结果为"11"
string c = 1 + "2"; //string和int也能相加结果为"12"
string d = "anser is " + true; //string和bool也能相加结果为"anser is True"
```

实际上，`string`类型能与前面介绍的所有的数字类型和他自己相加，相加的结果也是`string`类型。直接的字符串相加我们叫做**字符串拼接**。

于是，我们可以用这个方法将前面的加法程序的最后一行优化一下，优化成：

``` csharp
Console.WriteLine("Result of " + a + " + " + b + " is " + (a + b) + ".");
```

我们再次输入2和3，此时程序的运行结果为：

``` text
Input two numbers:
2
3
Result of 2 + 3 is 5.
```

实际上，这种方法不仅看起来复杂，写起来长，而且运行效率也低，因为做多少次字符串拼接，就会产生多少次字符串，中间的字符串创建了却没有被使用，就造成了浪费。

那么有没有一种方法能够实现类似于C语言`printf`的简洁输出方式，并且能够提高运行效率呢。

当然有，下面我们试着把加法程序的最后一行替换成：

``` csharp
Console.WriteLine($"Result of {a} + {b} is {a + b}.");
```

再次运行，依然输入2和3，程序运行结果为：

``` text
Input two numbers:
2
3
Result of 2 + 3 is 5.
```

我们发现在相同的输入下，输出的结果是完全相同的，也就是说这两种写法是等效的。

这种写法叫做内插字符串，是用来格式化字符串的。具体格式为在引号前面加一个美元符号，然后就可以在字符串里使用大括号来框住要输出的内容了。如上面所示，打括号里面的内容可以是变量、表达式或者是常量。只要使用内插字符串，就能按照你想要的格式格式化输出字符串了。

## 循环与条件语句

如果我们要想给加法程序添加一个功能，即如果结果是5，那么我们就停止程序，否则就一直加下去。

这个使用while循环可以很容易实现。幸运地是，在C\#中，while、do-while、for的循环语句的语法与C语言相同，于是我们就可以将程序改写成如下的内容。

``` csharp
using System;

namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {
            int a, b;
            do
            {
                Console.WriteLine("Input two numbers:");
                a = Convert.ToInt32(Console.ReadLine());
                b = Convert.ToInt32(Console.ReadLine());
                Console.WriteLine($"Result of {a} + {b} is {a + b}.");
            } while (a + b != 5);
            
            Console.WriteLine("The result is 5 and the program ends.");
        }
    }
}
```

我们用若干输入进行测试，输出为：

``` text
Input two numbers:
1
2
Result of 1 + 2 is 3.
Input two numbers:
10
-5
Result of 10 + -5 is 5.
The result is 5 and the program ends.
```

C\#的条件语句if、switch与三目表达式与C语言的格式相同。

对于switch语句，需要特别注意，非空的case必须接break，如：

``` csharp
int a = 10;
switch(a)
{
    case 1:
        Console.WriteLine("a is 1!");
        break;
    case 2:
    case 3: //合法，因为case2是空的
        Console.WriteLine("a is 2 or 3!");
        break;
    case 4:
        Console.WriteLine("a is 4!"); //不合法，因为4不是空case，必须有break
    default:
        Console.WriteLine("a is more than 4!");
        break;
}
```

这样的规则好处是可以避免忘记写break造成的错误。

C#中字符串也可以在switch中使用，如：

``` csharp
string str = "123456";
switch(str)
{
    case "":
        Console.WriteLine("str is empty!");
        break;
    case "123456":
        Console.WriteLine("str is 123456!");
        break;
    default:
        Console.WriteLine("str is something else.");
        break;
}
```

在C\#中，只要能比较的类型都能在switch中使用。

此外，在C\#中，所有的循环语句和条件语句中的判断条件必须是`bool`。如：

``` csharp
int a = 0;
if(a == 0) //合法，因为比较返回的是bool
{
    //Do something...
}

if(a) //不合法，因为a是int，不是bool
{
    //Do something...
}
```

而C\#的逻辑运算要求两边都必须是`bool`，这是与C语言的一个显著差异点。

这样的好处依然是防止编码错误，看下面的例子：

``` csharp
int a = 19;
if(a = 10)
{
    //Do something
}
```

上面的代码，在C语言中是合法的，但是在C\#中却不是合法的。我们要比较`a`是否与10相等，但是我们却少写了一个等号，这样就会造成在C语言中，无论a为何值，条件都会为真，并且`a`的值也会被修改为10，这不是我们想要发生的。

## 结束语

通过这节课的学习，我相信你已经学会了C\#的基本语法，并且能够编写简单的C\#程序了。编程是一个实践的学问，你需要通过一些实践来巩固今天学到的知识。你可以尝试用C#重写你的C语言课程作业来联系，所有操作都可以在`static void Main(string[] args)`这个函数中完成。
>C#的函数可以在函数中声明，如果你的C语言作业需要用到函数，请在Main的最顶部直接声明和实现它。
