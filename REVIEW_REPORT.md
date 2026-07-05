# paper-to-lecture-notes 技能 — 完整审查与提升报告

日期：2026-07-05 · 方法：多智能体审查（6 审查员 → 每条发现对抗核实 → 按文件修复 → 跨文件调和 → 机械化终审门）· 共 48 个智能体，全部机械检查（编译/渲染/解析）真实执行。

## 审查结果

50 条发现 → 对抗核实**确认 47**（12 major / 21 minor / 14 polish）、驳回 3。全部 47 条已修复落地。

代表性 major 修复：

- **CONFIG 路径防呆**（`build_workflow_template.js`）：5 个私人 Dropbox/worktree 实路径默认值 → 显式占位符 + 启动即检的 fail-fast 守卫（未配置则零智能体启动直接返回），原 Mpemba 路径保留为注释示例。
- **Referee 循环两处真 bug**：agent 返回 null 时的 TypeError 崩溃已加守卫；退出条件补回 rubric 规定的 ≥90/100 分数线（`A.threshold` 可调）。
- **调色板命名统一**：js 的 `accentRed`/缺 `inkgray` → 全包统一 5 色 `navy/mpred/teal/gold/inkgray`（LaTeX、Python、js 三处字节一致）。
- **阶段 6 排版层缺口**：见下方增强 E2。
- **图原型编译修复**：原型 A 补 amsmath 依赖；原型 C/D/F/G 的标签碰撞/失真标注逐个修正并重新渲染目检。
- **排版指南与 preamble 的漂移**：hyperref/tcolorbox 顺序表述写反、geometry 少写 a4paper、非法 `-halt-on-error=0` 参数、"4 色"实为 5 色等 8 处对齐。
- **SKILL.md**：死指针 `making_of.html` 改为存档说明；补无 Workflow 工具时的降级执行路径。

驳回示例：审查员建议删除 js 顶层 `return`（会破坏 Workflow 运行时的返回值契约，已改为在文件头注释说明 `node --check` 误报属设计使然）。

## 七项增强（经用户确认的方向）

- **E1 可移植性（可分享）**：全包 pdflatex 探测式解析（`command -v` → MacTeX → TeX Live glob）、poppler 说明、无 Workflow 工具的完整 fallback。
- **E2 内建 Typeset 阶段**：工作流新增 Assemble→**Typeset**→Figures 阶段，自动执行分层排版纪律（备份 plain preamble → 沙盒替换 → 三遍构建 → pdftoppm 渲染目检 → 应用）；工作流现在完整覆盖 SKILL.md 阶段 3–9。
- **E3 脚手架模板**：新增 `references/scaffold/`（master.tex、compile_one.sh、build_all.sh、contract_template.md、check_figure.sh），全部经冷启动实测（含并发编译无碰撞、带空格与 `[ ]` 的路径）；js 新增 `SKILLREF` 旋钮直接复用。
- **E4 成本档位**：js 新增 `MODE = 'light' | 'full'`——light 为廉价初稿档（单合并验证 lens、单轮 referee、跳过图审循环），但**永不裁剪**数值地基、干净构建与 Typeset；输出明示 "draft grade"。
- **E5 数值必须可视化（用户强制要求）**：`numbers.md` 中每个承重数值必须同时出现在至少一张图或专业排版表格中，裸引数字不合格——已写入 SKILL.md 承重原则、js STANDARDS + referee 检查（计入 Visualization 维度）、rubric 评分标准、contract 模板。
- **E6 文档瘦身**：漂移易发的重复段落改为单一事实源 + 指针（preamble 注释 → 指南；SKILL.md 阶段 8 → rubric）。
- **E7 图原型扩容**：7 → **11** 个原型，新增 H 数值对比图、I 调色板高亮结果表、J 流程/管线图、K 二维相图/区域图（全部编译 + 渲染目检通过）；新增 "Track 3: numbers → figures" 决策指引；`references/new_paper_checklist.md` 作为新论文上手清单。

## 终审门（全部通过，0 轮补救）

1. preamble 两遍编译 0 错误，标题页/章首页/定理盒页渲染目检正确；
2. 脚手架按 checklist 冷启动跑通（build_all 三遍干净、compile_one 双章并发无碰撞、check_figure 出图目检）；
3. 11 个图原型全部从当前文档新鲜提取、独立编译、渲染目检无碰撞；§2.1 matplotlib 骨架实跑出 PDF；
4. js 解析通过、禁调用扫描干净、meta.phases 与 phase() 严格吻合、fail-fast 守卫实测触发（零智能体启动）；
5. 调色板/TikZ 库/阈值/政策措辞跨 12 个文件一致，无死指针；rubric 权重和为 100、硬门恰为 G1–G6。

## 备注

- `build_workflow_template.js` 无法用普通 `node --check` 校验（顶层 return/await 属 Workflow 运行时契约），文件头已说明验证方法。
- 本目录是改进版；全局 `~/.claude/skills/paper-to-lecture-notes/` 仍是原版，未动。同步命令：
  `cp -R SKILL.md references ~/.claude/skills/paper-to-lecture-notes/`
