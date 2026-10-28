# lecture6 · 基础组件与布局系统

第 8 周课堂作业六的代码仓库，包含三个相互独立的 Flutter 工程：

| 目录 | 对应任务 | 说明 |
| --- | --- | --- |
| `profile_card/` | 案例复现 | 按实践指南第五节的三个步骤复现个人名片页 |
| `layout_lab/` | 自主实践 | 对齐任务卡、弹性分配、层叠角标、容器美化四个实验 |
| `clip_header_card/` | 独立研究任务（选做第三题） | 用 `ClipPath` + `CustomClipper` 做异形卡片头图 |

## 运行方式

```bash
cd profile_card   # 或 layout_lab / clip_header_card
flutter pub get
flutter run -d chrome
```

三个工程都只启用了 Web 平台，均可用 `flutter run -d chrome` 直接预览。

## 提交说明

案例复现按实践指南要求分为三次提交：骨架与对齐 → 容器美化与角标 → 对照设计稿验收。
自主实践按四个实验分步提交，每一步只做一件事。
独立研究任务第一次提交为实验工程，第二次提交补齐文档与结论。

## AI 使用标注（自主实践第 5 项）

本次作业允许使用 AI 辅助，使用情况如实标注如下：

- 案例复现：布局骨架由本人按指南步骤编写，AI 仅用于检查 `Expanded` 写法与排版间距是否与指南一致；每步代码均在本机 `flutter run` 验证后提交。
- 自主实践：四个实验的界面与交互由本人独立完成，AI 用于提示 `Wrap` 的 `runSpacing` 参数名和 `Stack` 中 `Positioned` 的边界写法；提示内容均经本人改写并在运行结果中验证。
- 独立研究任务：以 Flutter 官方文档（`ClipPath`、`CustomClipper`、`CustomPaint`）和 API 文档检索为主，AI 未参与结论生成，仅用于校对文档链接是否有效。

详细的逐条记录见进度报告第六节「AI 使用记录」。
