# 进度报告6（第8周·基础组件与布局系统）

> 使用方式：在模板上作答，作答完成后将全文复制到雨课堂答题区（图片无法粘贴时在雨课堂编辑器中手工重新上传），并将同一内容存入自己仓库 lecture6/progress.md。

## 一、任务理解

这次作业分成三块，彼此独立，所以我在 lecture6 仓库里建了三个文件夹：profile_card 做案例复现，layout_lab 做自主实践的五个基本要求，clip_header_card 做独立研究任务里的第三题。

按照案例复现的要求：要按实践指南的三步走，代码和指南一致，每完成一步提交一次，最后与设计稿对得上，运行时不能出现 RenderFlex 溢出的黄黑警告。自主实践的五个小任务分别是对齐任务卡（六种对齐场景）、弹性分配实验（Expanded 比例布局）、层叠角标（Stack+Positioned）、容器美化（圆角、阴影、剪裁），以及把 AI 用在哪里写清楚。

## 二、环境与工具

- 系统：Windows 11；Flutter 3.47.5 stable（Dart 3.13.4），运行目标为 Web，浏览器用 Chrome。
- 编辑器：Trae CN；AI 工具是里面自带的 TraeCode，用法是“贴代码＋贴现象＋问原因”，不直接要成品。

- 辅助工具：Flutter DevTools 的 Widget Inspector 看约束和实际尺寸，Console 看溢出报错；git 提交到 https://github.com/langjinbuhuitou/lecture6.git。
- 三个工程分别跑在 8091（profile_card）、8093（layout_lab）、8094（clip_header_card），方便来回切换对比。

## 三、过程记录

按时间顺序记录主要操作：

- 先建仓库、写 README，规划好三个工程目录，创建 profile_card 后提交 “chore: 初始化 lecture6 仓库与 profile_card 工程”。
- 案例复现第一步：在 main.dart 里搭 Scaffold＋Column 骨架，头像用 CircleAvatar，姓名和签名两行 Text，统计条用 Row 里三个 Expanded，标签用 Wrap 排六个。这一版故意不做装饰，只看结构和对齐，提交 “feat: profile skeleton with alignment”。

- 案例复现第二步：给整张卡片和统计条加 Container 装饰（白底、圆角、阴影、内边距），头像右下角用 Stack＋Positioned 加在线状态点，提交 “feat: card decoration & status badge”。
- 案例复现第三步：打开 DevTools 的 Widget Inspector，逐项看头像、统计条 Row、标签的 size 和 constraints，对着设计规格调间距；中间故意把三个 Expanded 删掉观察溢出，再改回来，提交 “feat: match design spec, zero overflow warnings”。

- 自主实践：新建 layout_lab，先抽一个 SectionCard 组件，把五个实验放在同一页，按“对齐→弹性→层叠→美化→AI 标注”的顺序做，每完成一项提交一次。
- 独立研究：新建 clip_header_card，先查 ClipPath 和 CustomClipper 的文档，再手写三个 clipper，边调路径坐标边截图对比，最后把过程写进 README，先后提交工程和文档两次。

- 收尾：三个工程分别跑 flutter analyze，layout_lab 跑 flutter test，又补了一次“加重超长内容”的小提交让溢出更明显，最后 push 到 GitHub。

## 四、关键代码

下面三段是这次最关键的代码，分别在卡片装饰、统计条分配和自定义剪裁上。

（1）整张卡片的容器装饰（profile_card/lib/main.dart 第 40–53 行）

```dart
Container(
  padding: const EdgeInsets.all(32),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: const [
      BoxShadow(color: Colors.black12, blurRadius: 16, offset: Offset(0, 6)),
    ],
  ),
  child: Column(mainAxisSize: MainAxisSize.min, children: [...]),
)
```

逐行看：Container 本身只是个组合器，padding 负责卡片四周留白，decoration 把底色、圆角和阴影放在一起；颜色必须写进 decoration 里，不能和 color 参数同时写，否则直接编译报错。Column 的 mainAxisSize 设成 min，卡片才会按内容高度收缩，不会把整个屏幕撑满。外层还套了一个 ConstrainedBox(maxWidth: 480)，窗口拉宽时卡片最宽就停在 480，不会被拉成一条。

AI 参与情况：这段骨架是 AI 给的，但颜色、圆角 20、内边距 32 这些数值是我照着设计规格改的。验证方式是运行后截图，再用 Inspector 看容器实际尺寸。

（2）统计条为什么要用 Expanded（profile_card/lib/main.dart 第 106–121 行）

```dart
Container(
  padding: const EdgeInsets.symmetric(vertical: 16),
  decoration: BoxDecoration(
    color: const Color(0xFFF7F8FC),
    borderRadius: BorderRadius.circular(16),
  ),
  child: Row(
    children: const [
      Expanded(child: _StatItem(value: '128', label: '关注')),
      _StatDivider(),
      Expanded(child: _StatItem(value: '2.4k', label: '粉丝')),
      _StatDivider(),
      Expanded(child: _StatItem(value: '9.8k', label: '获赞')),
    ],
  ),
)
```

逐行看：Row 拿到的是父级给的固定宽度（Inspector 里显示 368），三个 Expanded 的 flex 都是 1，于是把“368 减去两条 1px 分隔线”剩下的宽度三等分，三个数字块永远等宽、数字居中。这里最值得说的是不写 Expanded 会怎样：Row 会把三个 Text 按各自内容宽度依次排，累计超过 368 就溢出，这也是我后面做那个溢出实验的原因。

AI 参与情况：结构是课堂示范里的原样，Expanded 的作用是我在被 63px 溢出“教育”过一次之后才真正理解的，并不是抄上去就完事。

（3）波浪底边的自定义剪裁（clip_header_card/lib/main.dart 第 224–250 行）

```dart
class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height - 22);
    path.quadraticBezierTo(
      size.width * 0.25, size.height - 66,
      size.width * 0.5, size.height - 22,
    );
    path.quadraticBezierTo(
      size.width * 0.75, size.height + 16,
      size.width, size.height - 30,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
```

逐行看：getClip 收到的是子组件的真实尺寸，所以坐标全部按 size.width、size.height 的比例写，窗口变宽变窄时形状不会跑偏。两段 quadraticBezierTo 各是“起点—控制点—终点”三个参数，一上一下拼出波峰和波谷；最后先连到右上角再 close，就得到顶部完整、底边是波浪的头图。shouldReclip 返回 false，因为形状只跟尺寸有关，尺寸不变就不用重新算路径。

AI 参与情况：贝塞尔曲线的写法是问 AI 问来的，但控制点坐标是我一格一格试出来的——第一版波谷只有十几像素，看着几乎还是直边，把 66、+16 这些幅度加大之后才像波浪。

## 五、检查点结果

与设计稿一致：卡片宽 432（ConstrainedBox 的 480 减去页面两侧各 24 的留白），圆角 20，内边距 32，头像直径 96，姓名与签名间距 16 和 8，统计条上下各留 24，统计条内边距 16，标签间距 8，配色用 #F4F5F9 作页面底色、#4C6FFF 作主色、#32C48D 作在线点。Inspector 里统计条那一行 Row 实测 368×47，和 432−32×2=368 完全对得上。对照图见图 7。

无溢出告警：最终版本运行时控制台是干净的，没有 RenderFlex 提示。步骤三那次故意去掉 Expanded 的实验，报错和黄黑条都留在了图 4 和图 5 里，当作反面对照。

统计条为什么用 Expanded（检查点要口头讲的）：Row 的主轴约束是父级给的紧约束，宽度是定死的；Expanded 的作用就是把“剩余空间”按 flex 比例分给子项，所以三个数字块能等分并居中，也不会越过约束。不加 Expanded 时子项按自身内容宽度占位，三个数字加两条分隔线一旦超过 368，就必然溢出。

自主实践五项都跑通：六种对齐、三组 flex 比例、溢出开关、Stack 角标、容器美化、AI 标注都在同一页里（图 8–13）。独立研究第三题也完成了，同一张头图用三个 clipper 裁出斜切角、波浪底边和底部内凹弧（图 14），README 里逐条写了形状推导和踩过的坑。

## 六、问题与调试

问题一：统计条去掉 Expanded 之后溢出 63px

现象：把三个 Expanded 临时换成固定宽度之后，128、2.4k、9.8k 挤在一起，右侧出现黄黑斜纹，浏览器控制台刷出 “A RenderFlex overflowed by 63 pixels on the right”。

定位：报错里直接给了出错位置（profile_card/lib/main.dart:114:30）和 constraints: BoxConstraints(w=368.0)，说明这一行只有 368 宽，而三个数字块加两条分隔线要 431。再用 DevTools 的 Widget Inspector 选中这行 Row，右侧 Flex explorer 显示的 size、constraints 和报错完全一致，确认问题就在这一行，不是外层卡片。

解决：把三个 Expanded 加回来，flex 都保持 1，分隔线固定 1px 宽。改完 Inspector 里 Row 的 size 是 368×47，控制台不再报错。

理解：这就是“约束给多少就只能用多少”。Row 不会因为子项放不下就自己变宽，它只能按父级给的 368 排；要么让子项可伸缩（Expanded/Flexible），要么换行（Wrap），要么缩放（FittedBox），不能指望布局自己兜底。

问题二：ClipPath 头图“看起来没剪”

现象：三个 clipper 写好后运行，头图还是方方正正的，只有底边一点点形状变化，像没生效。

定位：先怀疑路径写错，把 Path 的坐标打印出来发现没问题；后来注意到头图 Container 没有写宽度，宽度是按内容收缩的，getClip 收到的 size 很小，形状被压缩在一小块区域里；加上内边距把内容顶到了裁剪范围外，看起来就更像没剪。

解决：给 Container 补上 width: double.infinity，高度从 152 调到 182 和 192，内边距改成 EdgeInsets.fromLTRB(24, 20, 24, 44)，同时把形状幅度（斜切 56、波谷 66/16、内凹 78）一起加大，三种形状才一眼能区分。

理解：ClipPath 只负责“把子组件的绘制裁成这个形状”，子组件本身多大、画在哪，还是由它自己的尺寸和约束决定的。

## 七、AI 使用记录

| 序号 | 用途 | 我的指令摘要 | AI 输出 | 我做的验证 |
|---|---|---|---|---|
| 1 | 案例复现骨架 | “用 Flutter 写一个个人名片页骨架，Scaffold＋Column，头像、姓名签名、三个统计块、标签云，先不要装饰” | 一份能跑的 main.dart 骨架 | 结构直接用了；统计块改成 Expanded，装饰全部自己写，运行看对齐 |
| 2 | Wrap 参数 | “Wrap 的横向和纵向间距分别是哪个参数？” | spacing 和 runSpacing | 照着改，看标签换行后的间距对不对 |
| 3 | 溢出定位 | 贴报错原文和统计条代码，问“为什么会溢出、应该怎么改” | 建议加 Expanded，并解释紧约束 | 按建议改回，控制台告警消失，再用 Inspector 复核尺寸 |
| 4 | Stack 徽标 | “头像右下角的在线点怎么压上去？” | Stack + Positioned，提示 clipBehavior: Clip.none | 数值自己调成 right:2、bottom:6，截图确认没超出卡片 |
| 5 | ClipPath 写法 | “CustomClipper 的 getClip 怎么写一条波浪底边？” | quadraticBezierTo 的用法和 shouldReclip 说明 | 坐标自己试，第一版太平，加大幅度后截图对比 |
| 6 | 报告文字 | “把这段调试过程改成通顺的书面表达，不要夸张” | 一段润色后的文字 | 按实际过程逐句核对，删掉了 AI 加的“完美解决”一类话 |

没用 AI 的地方：三个工程的页面结构、配色、间距数值，以及 README 里的结论，都是我自己定的；AI 给的建议都先在本地跑过、看过 Inspector 或截图之后才保留。

## 八、证据截图

*（本文件为报告正文的文本版，截图不随仓库上传，图 1–17 见随报告提交的 docx 插图。）*

*图1  案例复现第一步，只有骨架和对齐，还没有任何装饰。*

*图2  第二步加上卡片装饰和头像右下角的在线状态点。*

*图3  第三步按设计规格核对后的最终效果。*

*图4  故意去掉统计条里的 Expanded，三个数字挤在一起并出现黄黑斜纹。*

*图5  控制台报出“A RenderFlex overflowed by 63 pixels on the right”，定位到 main.dart:114。*

*图6  DevTools 的 Widget Inspector 选中统计条那一行 Row，右侧显示 size 368×47 和对应约束。*

*图7  设计稿对照：左边是按规格整理的对照稿，右边取自第三步的运行截图，用来逐项核对尺寸与配色。*

*图8  自主实践第 1 项，六种对齐方式并排展示，用于对比主轴和交叉轴的效果。*

*图9  第 2 项，flex 1:1:1、2:1:1、1:2:1 三组比例的实际宽度分配。*

*图10  打开“超长内容”开关后，中间栏的小方块超出这一栏的约束，出现黄黑斜纹和 OVERFLOWED 提示。*

*图11  第 3 项，Stack＋Positioned 做的封面角标和头像徽标。*

*图12  第 4 项，圆角阴影卡片、ClipRRect 渐变态和 ClipOval 圆形头像。*

*图13  第 5 项，页面里直接标出哪几处用过 AI、自己是怎么验证的。*

*图14  独立研究第 3 题，同一张头图用三个 CustomClipper 裁出斜切角、波浪底边和底部内凹弧。*

*图15  lecture6 的提交记录，三块任务都是分步提交，工作区干净，远程地址一并显示。*

*图16  flutter --version 和 doctor 摘要，本地环境没有缺项。*

*图17  三个工程 flutter analyze 都是 No issues，layout_lab 的测试也通过。*

## 九、自评

- 案例复现：完成。三步都有独立提交，代码与指南一致，能正常运行。
- 检查点：设计稿逐项对照过，最终版本没有溢出告警，统计条为什么用 Expanded 能讲清楚。

- Git 规范：一共 14 次提交，信息用了 feat/chore/fix/docs/test 前缀，每次提交对应一个能跑的小步，README 说明了三个工程的关系。
- 报告记录：过程、代码、问题和截图都按实际写，没有编造运行证据。

- 自主实践五项：六种对齐、三组比例、层叠角标、容器美化、AI 标注全部完成。
- 独立研究第三题：三种 CustomClipper 形状都做出来了，README 有探索过程和结论。

不足的地方：layout_lab 那一页做得比较挤，留白和小屏适配没细调；ClipPath 只用到了二次贝塞尔，三次贝塞尔和路径运算还没试；独立研究的另外两个小题（约束传递实验、FittedBox 缩放策略）这次没做。

## 十、一句话收获与下一步计划

一句话收获：这周最大的感受是，布局不是“把东西摆在哪”，而是先想清楚谁给约束、谁报尺寸、谁决定位置。

下一步计划：把独立研究剩下的两个小题补上，尤其是约束传递实验，正好能把这次溢出的理解再夯实一遍；第 7 课要讲表单和输入，准备先把 profile_card 里的统计条、标签抽成独立组件练手，这样下次改页面就不用在一个 main.dart 里翻来翻去了。
