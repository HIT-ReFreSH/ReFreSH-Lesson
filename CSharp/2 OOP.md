# 第2讲 面向对象

## 引言

我们在课上学习的C语言是一种面向过程的语言，而C\#是一种面向对象的编程语言。我们在上一节课中并没有使用到C\#面向对象的部分，这节课我就来带领大家走进面向对象的精彩世界。

## 对象是什么

我们先从C语言的链表看起，下面是一个经典的C语言链表实现：

``` c
struct linked_list
{
    int value;
    struct linked_list *next;
}
```

我们可以清楚地看到C语言的结构体里包含了**数据**，我们现在想给这个链表添加一个功能，功能是计算这个链表里元素的个数。一般来说，我们可以这么写：

``` c
int get_count(struct linked_list *list)
{
    int count = 1;
    while(list->next)
    {
        list = list->next;
        count++;
    }
    return count;
}
```

然后我们对于链表的插入删除等工作，都会定义一个函数来完成。

如果我们想要拓展一下链表，想要在这个链表里增加一个int，这样我们只能定义一个新的结构体：

``` c
struct two_int_linked_list
{
    int value;
    int value2;
    struct two_int_linked_list *next;
}
```

这个新的结构体和之前的结构体不具有任何联系，之前所有的代码都需要重新修改。而我们仅仅是给结构体里添加一个数据，就必须定义一个新的结构体。如果我们以后要将这个结构体里添加更多的数据，比如让其储存非整数数据，那么对于每一个需求，我们都需要定义一个新的结构体，并且要将原来结构体里的内容复制过去，这样我们就必须面对很多重复的代码。

同时，我们观察到，如果要计算新链表的元素个数，原来的`get_count`的代码逻辑不需要改变，只需要改变参数的类型就可以。但是我们不能这么做，我们必须新定义一个函数来计算新链表的元素个数，并且还要使用相同的代码逻辑。

仅仅两个小小的需求，就会极大地增加我们C语言代码中的无效代码量，那么我们有没有办法复用之前的代码，让我们的程序变得更简洁呢？

显然，我们可以观察到，**功能和数据**两者通常应该是**关联在一起**的，而不应该像这样被拆分开。同时，具有**相似结构的数据**也应该通过某种方法被**关联起来**，这样我们就不需要写很多无用的代码了。

**对象(Object)** 就为了实现这一目的，应运而生了。一类对象仅仅内容数据不同的对象被归为一个**类(Class)**，它看起来像一个升级的结构体，除了能保存**数据**外，还能保存**方法**和**特性**。在C\#中，所有的函数都写在类里，没有不在类中的函数，而类中的函数我们叫做**方法(Method)**，类中的数据我们叫做**字段(Field)**，这些字段和方法统称为类的 **成员(Member)**。对于**特性**，我们会在之后的课程中会进行再探讨。

类除了能保存数据之外的信息，还可以实现整体上的复用(如上面提到的`two_int_linked_list`和`linked_list`)，一个类可以完整拥有另一个类的所有成员(如`two_int_linked_list`就可以拥有`linked_list`的所有数据和功能)，这个过程叫做 **(类的)派生**。如果期望一个类拥有一个现存的类A的所有成员，那么可以用类A派生出一个新类B，称作新类B**继承**了旧类A。派生类B具有继承类A的所有数据和功能。

## C#中的方法、属性与字段

下面我们在C\#中定义一个最简单的类。

``` csharp
public class MyClass
{
    private int _myInt;
}
```

首先`class`之前有一个`public`，`public`是一个访问标识符，说明谁能访问这个类。在C\#中有4种访问标识符，说明了4种不同的访问权限。

| 访问标识符 | 使用说明                 |
| ---------- | ------------------------ |
| public     | 谁都可以访问             |
| internal   | 同一个项目内能访问       |
| protected  | 只有自己和被派生的子类才能访问 |
| private    | 只有自己能访问         |

>所以上文提到的“派生类B具有继承类A的所有数据和功能”并不严谨，尽管这些数据和功能客观上拥有，但B并不能访问其中的`私有(private)`成员。

后两种访问标识符`protected`和`private`只能用于类的成员，因此在这里定义类的时候只能使用`public`和`internal`。定义类时的访问标识符可以省去，在这种情况下定义类默认的访问标识符为`internal`，但是为了保证可读性，如果你要写一个`internal`类，那么你就不应该将`internal`省去。

在访问标识符-`class`关键词-类名之后，有一个大括号包裹了类中的所有内容。

类第一行中的`private int _myInt;`定义了**字段**，其中，`private`是访问标识符，`int`是字段的类型，`_myInt`是字段的名称。**字段**占用类的内存空间，是**实打实**储存的数据。字段的默认访问标识符为`private`，基于与前面相同的原因，不应该省去`private`。

> 一般而言，在C\#代码中，字段都是`private`的，并且名称以下划线开头。在良好的C\#代码中，不应该出现任何`public`字段。

但是在不使用`public`字段的情况下，类中的数据永远不会被外界所知，这显然不能满足我们的需求。而如果使用`public`字段，外界对数据的访问又毫无限制，我们有的时候只希望外部只读/只写特定数据，也希望外部不要写入非法数据；因此，我们对字段进行**封装**，使用两个方法将其暴露给外部。

```csharp
public class MyClass
{
    private int _myInt;
    
    public int GetMyInt()
    {
        return _myInt;
    }
    
    public void SetMyInt(int value)
    {
        _myInt = value;
    }
}
```

在C\#中定义方法与C语言定义函数一样简单，但是要在前面加上访问标识符。方法与字段的默认访问标识符相同。在C\#中，方法的名字应该以大写字母开头。

那么我们应该怎么访问这两个标记为`public`的方法呢，首先，这两个方法不能直接调用，必须先创建一个这个类的实例。与C语言中的结构体类似，我们需要划出一片内存空间来储存这个类，在C\#中，这通过关键词`new`来完成。

``` csharp
var myClass = new MyClass();
```

这样我们就创建了一个名叫`myClass`的`MyClass`实例，`new`与C语言的`malloc`类似，都是申请内存，但是C\#中`new`返回的类型是这个类，`malloc`返回的是通用类型指针。而且C\#`new`申请的内存不需要`free`，系统会检测你不需要的内存，自动执释放不需要的空间。

>`malloc`和`new`都在堆中分配内存。C语言还可以直接在栈中分配结构体的内存空间`struct my_struct struct1;`，C\#的类不支持在栈中分配内存，相同形式只会声明一个变量，但是不会分配实际的储存空间。

在创建了一个`MyClass`实例之后，调用其方法就很简单了。

``` csharp
int oldValue = myClass.GetMyInt();
myClass.SetMyInt(10);
```

而类中的方法，访问到的方法、字段都是当前实例的，也就意味着多个实例中的数据是互不干扰的。

考虑如下的代码：

``` csharp
var my1 = new MyClass();
var my2 = new MyClass();

my1.SetMyInt(10);
my2.SetMyInt(20);

Console.WriteLine(my1.GetMyInt()); //10
Console.WriteLine(my2.GetMyInt()); //20
```

虽然添加`GetXXX`，`SetXXX`之后，代码的封装性变好了，但是我们每次需要调用数据的时候都需要调用方法，这造成了许多的不便。但是不要怕，C\#有语言功能**属性**，能够让我们在方便的情况下更好地封装。

我们改写上面的类：

``` csharp
public class MyClass
{
    public int MyInt { get; set; }
}
```

改写后的类与改写前的类逻辑上有着完全相同的功能。我们将这种写法称为**自动属性**，自动属性会帮我们自动生成一个**字段**、和get与set方法。

使用属性与使用C语言结构体中的数据一样简单：

``` csharp
var my1 = new MyClass();
var my2 = new MyClass();

my1.MyInt = 10;
my2.MyInt = 20;

Console.WriteLine(my1.MyInt); //10
Console.WriteLine(my2.MyInt); //20
```

但是，我们使用属性的时候，并不总想让所有人都读取属性的内容，因此我们可以这么写**自动属性**以满足我们的各种需求：

``` csharp
public class DemoClass
{
    public int IntA { get; set; } //所有人都能读写
	private int IntB { get; set; } //读写的级别是private
    public int IntC { get; private set; } //所有人都能读，但是写的级别是private
   	private int IntD { get; public set; } //不合法，因为部分的读写级别不能高于全局
}
```

但是，**自动属性**并不是总能满足我们的需求，比如我们要记录`MyInt`的变化，将其打出来。在前面手动使用`GetXXX`、`SetXXX`的情况下，这是非常简单的，只需要添加代码就可以的。使用**手动属性**，我们依然可以在很方便的情况下完成相同的效果。

``` csharp
public class MyClass
{
    private int _myInt;
    public int MyInt 
    {
        get
        {
            return _myInt;
        }
        set
        {
            _myInt = value;
            Console.WriteLine($"My int changed to {_myInt}.");
        }
    }
}
```

使用方法依然不变：

``` csharp
var myClass = new MyClass();
myClass.MyInt = 10; //这里会输出My int changed to 10.
Console.WriteLine(myClass.MyInt);
```

其中手动属性的格式如上所示，并且也可以在`get`或`set`前加上访问限定符限制其访问范围。其中`get`方法是一个没有参数需要返回属性类型的方法，`set`方法是一个有参数无返回值的方法，其只有一个参数，参数类型与属性类型相同，名称是`value`。此外，手动属性的`get`与`set`是可选的，可以只有一种，也可以两个都有。而自动属性的`get`是必选的，不能只有`set`，没有`get`。知道这些知识，你也可以轻松地编写自己的手动属性。

此外，C\#中的字段与自动属性都可以有初值，比如自动属性的初值要写在大括号右边，比如

``` csharp
public int IntE { get; } = 5; //只读属性，只能在初始化时赋值
public int IntF { get; set; } = 5; //初值为5，赋值之后还可以修改
```

而字段初值写法类似于变量声明，比如

``` csharp
private int _myInt = 5;
```

## C\#中的构造函数

对于之前的`MyClass`，如果我们还想加一个功能，比如能够动态设置`MyInt`初值，而不是每次都是5，应改怎么办呢。

这时候就需要用到构造函数了，构造函数是关键词`new`初始化类时会调用的一种特殊方法，构造函数可以有很多个，但是其参数必须不同。

比如

``` csharp
public class MyClass
{
    public int MyInt { get; set; }
    
    public MyClass()
    {
        MyInt = 5;
    }
    
    public MyClass(int initValue)
    {
        MyInt = initValue;
    }
}
```

> 如果定义了构造函数，并且没有定义没有参数的构造函数，那么就不能通过new MyClass()来创建MyClass实例了，必须使用有参数的版本。

我们使用的时只需要：

``` csharp
var my1 = new MyClass(); //合法，使用没有参数的构造函数，MyInt初值是5
var my2 = new MyClass(10); //同样合法，使用第二个构造函数，MyInt初值是10
```

而构造函数的定义方式，我们从示例可以看出，需要访问标识符-类的名字-参数列表定义，其他的与普通方法无异。

此外，为字段和属性设定的初值，会在构造函数之前就设定好了，也就是说

``` csharp
public class MyClass
{
    public int MyInt { get; set; } = 5;
    
    public MyClass()
    {
        MyInt = 5;
    }
    
    public MyClass(int initValue)
    {
        Console.WriteLine(MyInt); //这里会输出5
        MyInt = initValue;
    }
}
```

而只读自动属性，在构造函数里仍可赋值，如

``` csharp
public class DemoClass
{
    public int MyInt { get; } = 5;
    
    public MyClass()
    {
        MyInt = 5; //合法
    }
    
    public MyClass(int initValue)
    {
        MyInt = initValue; //合法
    }
}
```

在声明字段的时候，可以使用`readonly`或`const`将字段声明称自读字段或者常量字段，二者的区别是`const`常量字段必须有初值，且构造函数中也不能赋值；`readonly`只读字段不一定需要有初值，在构造函数中能随意赋值。

``` csharp
public class DemoClass
{
    private readonly int _a = 5; //合法
    private readonly int _b; //合法，只读字段可以没有初值
    private const int c = 6; //合法
    private const int d; //不合法，常量字段必须有初值
    
    public DemoClass()
    {
        a = 6; //合法，只读字段可以在构造函数中赋值
        c = 10; //不合法，常量字段不能在构造函数中赋值
    }
}
```

## C\#中的方法重载

我们在学习构造函数的时候，发现构造函数可以有很多个，那么普通的方法能不能也有很多个相同的名字的呢。答案当然是肯定的，我们把相同名字，参数不同的方法叫做**重载方法**。

要重载方法，必须满足下面的条件：

- 方法名相同。
- 方法参数不同，返回值可以不同也可以相同

我们看下面的例子：

``` csharp
public class OverloadDemo
{
    public void Overload() //假设为现有方法
    {
        
    }
    
    public void Overload() //不合法，参数相同（都为没有参数）
    {
        
    }
    
    public int Overload() //不合法，虽然返回值不同，但是参数相同
    {
        
    }
    
    public void Overload(int a) //合法，参数不同
    {
        
    }
    
    public int Overload(long a) //合法，参数数量相同，但类型不同，返回值无所谓相不相同
    {
        
    }

    public void Overlord() //合法，因为名称不同(?)
    {
        
    }
}
```

在使用重载的方法的时候，编译器会自动推测你调用的是哪一个方法。

## 值类型与引用类型

