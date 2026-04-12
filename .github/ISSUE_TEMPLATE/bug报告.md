---
name: Bug报告
about: 汇报Bug
title: "[BUG]"
labels: bug
assignees: gameswu
type: Bug

---

**描述问题**
简要描述你遇到的排版错误或编译问题。

**最小化错误示例**
> [!IMPORTANT]
> **请务必提供一段可以直接运行并复现问题的代码。** 这样能极大提高解决问题的速度。
```latex
\documentclass{template-name}
% 请在此处添加触发问题的最简代码
\begin{document}
    Hello World.
\end{document}
```

**编译环境**
请填写你的编译配置，这对定位宏包冲突至关重要：
- **操作系统 (OS):** [例如 Windows 11, macOS 14, Ubuntu 22.04]
- **TeX 发行版:** [例如 TeX Live 2025, MikTeX, MacTeX]
- **编译引擎:** [例如 XeLaTeX, LuaLaTeX, pdfLaTeX]
- **编辑器:** [例如 VS Code + LaTeX Workshop, TeXstudio, Overleaf]
- **模板版本:** [例如 v1.0.2 或 Git Commit Hash]

**复现步骤 (Steps to Reproduce)**
1. 使用 `XXXX` 引擎编译。
2. 在第 `XX` 行添加了 `XXXX` 内容。
3. 出现报错信息：`......`（或者排版样式不符合预期）。

**预期结果 (Expected Behavior)**
描述你期望看到的排版效果（如果可以，请附上对比图）。

**错误日志/截图 (Log / Screenshots)**
- 如果有编译报错，请上传 `.log` 文件中的关键片段。
- 如果是视觉上的排版问题，请附上 PDF 截图。

**其他补充 (Additional Context)**
是否安装了特定的本地字体？是否使用了特殊的宏包？
