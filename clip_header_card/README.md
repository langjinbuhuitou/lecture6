# clip_header_card · 用 ClipPath 做异形卡片头图

独立研究任务（选做）第三题。目标：不用第三方库，只用 Flutter 自带的 `ClipPath` + `CustomClipper<Path>`，
把一张普通卡片头图剪成自定义形状。

## 一、探索过程

### 1. 先确认 ClipPath 的职责边界

查 [ClipPath 的 API 文档](https://api.flutter.dev/flutter/widgets/ClipPath-class.html)：
它只是"按给定的 `CustomClipper<Path>` 裁剪 child 的绘制区域"，本身不产生形状，也不负责阴影和圆角。
所以思路确定为：`Container(gradient)` 负责外观，`ClipPath` 负责轮廓，两者嵌套。

查阅 [CustomClipper](https://api.flutter.dev/flutter/rendering/CustomClipper-class.html) 时注意到两个必须实现的方法：

- `Path getClip(Size size)`：拿到子组件实际尺寸，返回裁剪路径；
- `bool shouldReclip(oldClipper)`：是否需要重新裁剪。形状只依赖构造参数时返回 `false` 即可，
  返回 `true` 会让每一帧都重算路径。

### 2. 路径怎么画

[Path 的文档](https://api.flutter.dev/flutter/dart-ui/Path-class.html) 里有 `lineTo`、`quadraticBezierTo`、`arcTo` 等。
实践里发现三个要点：

1. 起点默认在 `(0, 0)`，如果从 `(0,0)` 开始画，必须显式 `moveTo(0,0)` 或者第一条 `lineTo(0,0)`，
   否则路径是从原点"凭空"开始的；
2. 形状要 `close()`，否则收尾那条边不会自动补上，填充会缺一块；
3. 坐标必须用 `size.width` / `size.height` 表达，不能写死像素，否则换个卡片宽度形状就错位。

### 3. 三个形状的推导

| 形状 | 关键路径 | 说明 |
| --- | --- | --- |
| 斜切角 | `lineTo(w, h-cut)` → `lineTo(w*0.62, h)` → `lineTo(0, h)` | 右下角沿一条斜线切掉，切角高度由构造参数 `cut` 控制 |
| 波浪底边 | 两段 `quadraticBezierTo`，控制点在底边上下交替 | 控制点一上一下，就会得到起伏；第二个控制点取 `h+8` 让波谷略低于底边 |
| 内凹弧 | 底边用 `quadraticBezierTo`，控制点放在 `h-52` | 控制点向卡片内部收，贝塞尔曲线就向内凹 |

### 4. 踩坑记录

- **头图没撑满卡片**：一开始只给 `Container` 设了 `height`，`ClipPath` 的路径按子组件实际宽度算，
  结果头图缩在左边一小块。加上 `width: double.infinity` 后头图才和卡片同宽。
- **看起来"没剪"**：`ClipPath` 默认 `clipBehavior: Clip.antiAlias`，如果路径本身和矩形一样，就看不出变化。
  验证方法是把路径改成夸张的折线，确认确实被剪了，再调回设计值。
- **边界被裁掉**：`ClipPath` 会裁掉超出路径的一切，头图上的文字内边距必须留够，
  否则文字下半截会被波浪底边切掉。三个卡片都留了 `bottom: 40` 左右的内边距。

## 二、结论

1. `ClipPath` + `CustomClipper<Path>` 实现异形头图的关键只有一句：**用相对 `size` 的坐标描述轮廓，路径 `close()`**。
   装饰（渐变、圆角、阴影）仍交给 `Container` / `BoxDecoration`，两者互不干扰。
2. 三种形状里，直线折角的成本最低、可读性最好；波浪与内凹弧需要反复调贝塞尔控制点，
   建议先在纸上标出控制点的相对位置（如 `(0.25w, h-46)`）再写代码。
3. `shouldReclip` 返回 `false` 是这类静态形状的通用做法；只有当形状依赖外部状态（例如跟随动画变化的 `cut`）时才需要返回 `true`。
4. 若只需要圆角或圆形，`ClipRRect` / `ClipOval` 更简单，`ClipPath` 的价值在于"矩形之外的轮廓"。

## 三、参考资料

- ClipPath：https://api.flutter.dev/flutter/widgets/ClipPath-class.html
- CustomClipper：https://api.flutter.dev/flutter/rendering/CustomClipper-class.html
- Path：https://api.flutter.dev/flutter/dart-ui/Path-class.html
- 《Flutter实战》第 5 章"剪裁"一节
- 布局可视化：https://docs.flutter.dev/development/ui/layout
