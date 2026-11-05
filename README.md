# Partial code accompanying the manuscript

**A Functional Safety Verification Method Combining Simulation-Based Fault Injection and Formal Verification**

## Availability during peer review

The manuscript is currently under peer review. At this stage, we can share only a small subset of the code. This repository is a limited preview, not the complete experimental implementation or a reproduction package.

After the paper is accepted, we plan to progressively sanitize additional materials by removing sensitive and environment-specific information before considering further releases. The scope and timing of those releases are not guaranteed. This repository is **not guaranteed to contain the complete or latest code**, and may differ from the internal development version.

## Included file

`formal_property_examples.sv` is the only code file in this release. It collects three illustrative SystemVerilog Assertion examples adapted from the manuscript:

- ECC alarm response;
- an AHB-to-APB write-response condition;
- FIFO empty-read and full-write checks.

The interface wrapper is provided for readability. These excerpts are not presented as the complete original experimental property suite, and no proof results are claimed for this standalone file.

## Scope and use

Read the examples with the formal-verification discussion in the manuscript. To use them in a design, map the ports to the actual RTL signals and supply the relevant clock/reset setup, environment assumptions, and tool configuration. Check the acceptance conditions, clock-domain relationships, response windows, and FIFO semantics for that design.

The examples preserve the manuscript's non-overlapped implication (`|=>`) followed by a delay range. Thus, the ECC example checks a response 2–4 sampled clock edges after its antecedent, and the write-response example checks 2–6 `hclk` edges after its antecedent. They are illustrative conditions, not complete protocol or functional-safety specifications.

The release does not include the DUT RTL, full properties and assumptions, bind files, fault-injection infrastructure, VPI implementation, test-ordering implementation, datasets, or experimental reports. It cannot independently reproduce the manuscript's numerical results. No EDA compilation or formal proof of this standalone wrapper has been performed for this release.

## 中文说明

论文目前仍在审稿期间，因此现阶段仅分享少量代码。本仓库只包含一个代码文件，整理了正文中的三条说明性 SVA 示例；它不是完整实验工程，也不代表已公开原实验的全部属性。

论文接收后，计划逐步对更多材料进行脱敏，去除敏感内容和环境相关信息，再酌情更新。本仓库**不保证代码完整，也不保证与内部最新版本一致**；后续公开范围和时间不作保证。使用示例前，需要结合实际 RTL 补充信号绑定、环境约束及工具配置。
