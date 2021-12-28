---
title: "Go plus 浅尝一下"
excerpt: "GoPlus - The Go+ language for engineering, STEM education, and data science."
---

项目地址: https://github.com/goplus/gop.git

## 安装

按照文档提示

```shell
git clone https://github.com/goplus/gop.git
cd gop
./all.bash
```

安装完之后：

<figure>
  <img src="{{ '/assets/images/install_go_plus.png' | relative_url }}" alt="after_install">
</figure>

### 运行hello world程序

```go
// tmp/helloworld.gop
package main

func main() {
	println("hello world!")
}
```

![hello_world]({{ "https://img-community.csdnimg.cn/images/5efdcda730a548b1a98ae1ff84a698cf.png" | relative_url }})

**ATTENTION⚠️**  解决(非代码问题)运行不成功

在用 `gop run tmp/helloworld.gop` 运行的过程中，刚开始始终运行不成功

检查`tmp`目录下存在`go.mod`文件，删除该文件再运行，成功解决✅

![run_error]({{ "https://img-community.csdnimg.cn/images/6518e24f05fd45f4bbd1c52a53b0d773.png" | relative_url }})


### 变量

`gop`支持不同类型的变量联结：

```go
// tmp/variables.gop
package main

func main() {
	x := 123.1 - 3i
	y, z := "Hello, ", 123
	println(y+"complex:", x+1, "int:", z)
}
```

![variables]({{ "https://img-community.csdnimg.cn/images/a4504ad8d9c74bfa99de0a545aa0fd4e.png" | relative_url }})

如果用go语言实现以上逻辑：
```go
// tmp/variables.go
package main

import "fmt"

func main() {
	x := 123.1 - 3i
	y, z := "Hello, ", 123
	fmt.Printf("%scomplex:%v int: %d\n", y, x+1, z)
}
```

在go语言中需要用format来格式化输出，gop中可以忽略变量的类型，直接用println进行输出

### gop 玩锤子剪刀布游戏

大家应该都会玩“锤子剪刀布”的游戏：两人同时给出手势，胜负规则如图所示：

![猜拳图片]({{ "/assets/images/caiquan.jpeg" | relative_url }})

现给出两人的交锋记录，请统计双方的胜、平、负次数，并且给出双方分别出什么手势的胜算最大。

**输入格式：**

输入第 1 行给出正整数 N（≤10
5
），即双方交锋的次数。随后 N 行，每行给出一次交锋的信息，即甲、乙双方同时给出的的手势。C 代表“锤子”、J 代表“剪刀”、B 代表“布”，第 1 个字母代表甲方，第 2 个代表乙方，中间有 1 个空格。

**输出格式：**

输出第 1、2 行分别给出甲、乙的胜、平、负次数，数字间以 1 个空格分隔。第 3 行给出两个字母，分别代表甲、乙获胜次数最多的手势，中间有 1 个空格。如果解不唯一，则输出按字母序最小的解。

**输入样例：**

    10
    C J
    J B
    C B
    B B
    B C
    C C
    C B
    J B
    B C
    J J

**输出样例：**

    5 3 2
    2 3 5
    B B

```go
// tmp/cai_quan.gop
package main

import "fmt"

func main() {
	var count int
	_, _ = fmt.Scanf("%d", &count)       // 读取输入的比赛次数
	a := make(map[int]string, count)
	b := make(map[int]string, count)
	
	var aWin, aLose, aTie int      		 // a 赢，输，平
	var bWin, bLose, bTie int
	var aMostWinGestureCount int		 // a最多次赢的次数
	var bMostWinGestureCount int
	var aMostWinGesture string		     // a最多次赢的手势
	var bMostWinGesture string
	
	aWGesture := make(map[string]int)    // 用map集合来记录每个回合的出拳
	bWGesture := make(map[string]int)

	// 循环count次录入回合数据
	for i := 0; i < count; i++ {
		var tempA, tempB string
		_, _ = fmt.Scanf("%s %s", &tempA, &tempB) 
		a[i], b[i] = tempA, tempB
		
		// 计算输赢和手势数据
		if a[i] == "C" && b[i] == "J" || a[i] == "J" && b[i] == "B" || a[i] == "B" && b[i] == "C" {
			aWin++
			aWGesture[a[i]]++
			bLose++
		} else if a[i] == "C" && b[i] == "B" || a[i] == "J" && b[i] == "C" || a[i] == "B" && b[i] == "J" {
			aLose++
			bWin++
			bWGesture[b[i]]++
		} else {
			aTie++
			bTie++
		}
	}

	// 计算a最多次赢的手势
	for k, v := range aWGesture {
		if v >= aMostWinGestureCount {
			if aMostWinGesture == "" {
				aMostWinGesture = k
			} else if aMostWinGesture > k {
				aMostWinGesture = k
			}
		}
	}

	// 计算b最多次赢的手势
	for k, v := range bWGesture {
		if v >= bMostWinGestureCount {
			if bMostWinGesture == "" {
				bMostWinGesture = k
			} else if bMostWinGesture > k {
				bMostWinGesture = k
			}
		}
	}

	// 输出结果
	fmt.Printf("%d %d %d\n", aWin, aTie, aLose)
	fmt.Printf("%d %d %d\n", bWin, bTie, bLose)
	fmt.Printf("%s %s\n", aMostWinGesture, bMostWinGesture)
}
```


<!-- [“我的GO+初体验” | 征文活动进行中......](https://bbs.csdn.net/topics/603464006) -->
