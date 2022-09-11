# DubheKit - Swift 语言描述的组件化架构

## 组件化背景
复杂业务场景下的 UIViewController 臃肿，没有架构支持的情况下，伴随着频繁迭代的需求，代码持续裂化，搭建组件化架构解决业务痛点。

## 业务接入方式

Example 工程
已一个简单的消息页 Example 工程为例，其 Feature 包括：
- 拥有一个 NavigationBar，当输入框 TextField 被激活时，展示“You are typing...”，否则展示“You are not typing.”。
- 拥有一个 InputView，包括 TextField 和 SendButton。用户输入内容后，可以进行内容的发送。
- 拥有一个 MessageCollectionView 展示当前用户发送的消息。
- 需要对用户发出的信息进行检查，根据一定条件触发一个弹窗，内容可由不同业务定制，如安全弹窗、彩蛋弹窗。

![](https://github.com/LLLLLayer/picture-bed/blob/main/img/dubheKit/DubheKit1.png) ｜ ![](https://github.com/LLLLLayer/picture-bed/blob/main/img/dubheKit/DubheKit2.png) | ![](https://github.com/LLLLLayer/picture-bed/blob/main/img/dubheKit/DubheKit3.png)
---|---|---

## 组件分析

![](https://github.com/LLLLLayer/picture-bed/blob/main/img/dubheKit/DubheKit4.jpeg)
我们可以将上述的业务逻辑分解为四个组件：
1. ListComponent  为消息列表组件，进行消息列表的展示。
- ListComponentInterface 为 ListComponent 对外暴露的接口。
- 暴露 send(message:) 发送消息的能力。
2. InputComponent 为输入组件， 提供消息的输入与发送。
- InputComponentAction 为 InputComponent 对外发布的事件。
- 发布 update(state:) 输入状态改变的事件。
- 发布 originYWillChange(newValue:duration) 输入框的 originY 变更的事件。
3. NavigationComponent 为导航栏组件，展示导航栏和用户输入状态。
4. TipsComponent 为弹窗组件，进行发送的消息的检查并在必要时候弹窗。是懒加载的组件
- TipsComponentInterface 为 TipsComponent 对外暴露的接口。
- 暴露 checkAndShowtips(message:) 检查消息并弹窗的能力。
5. SafeTipsComponent 为安全检查辅助组件，负责提供安全信息。是 TipsComponent 的子组件。
- SafeComponentInterface 为 SafeTipsComponent 对外暴露的接口。
- 暴露 message() 提供安全检查文案。
6. LuckTipsComponent 为彩蛋检查辅助组件，负责提供彩蛋信息。是 TipsComponent 的子组件。
- LuckComponentInterface 为 LuckTipsComponent 对外暴露的接口。
- 暴露 message() 提供安全检查文案。

