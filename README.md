# Vim 五笔输入法

**Vim_wubi** 是使用 `vim9script` 编写的五笔输入法。

代码复制自 [Joe-C-Ding/imtable](https://github.com/Joe-C-Ding/imtable.git)，后使用 `vim9script` 改写。

## 依赖与安装

### 依赖

需要 Vim 9.0 以上，需要的功能如下：

| 功能              | 引入版本 |
| ----------------- | :------: |
| feedkeys()        |   7.0    |
| InsertCharPre     |   7.4    |
| Vim packages      |   8.0    |
| Lambda expression |   8.0    |
| Popup-windows     |   8.2    |
| Method call       |   8.2    |
| Vim9script        |   9.0    |

### 安装
vim-plug:

```vimscript
Plug 'AllanDowney/vim-wubi'
```

也可 `git clone` 到 `$HOME/.vim/pack/edit/opt` 下，在 `.vimrc` 中加上

```vimscript
packadd vim-wubi | ImBuild
```

如果想禁用插件，只需注释掉 `packadd` 这一行。

## 已实现的功能

1. 支持分号(;)、撇号(')、逗号(,) 次选、三选、四选
2. 支持中英文标点切换(\<C-l>)，按键可配置
3. 临时英文输入(\`)，按键可配置
4. 支持 `z` 键重复最后一次输入
5. 回车可用于编码上屏
6. 自造词
7. 字词扩展显示，可禁用
8. 输入数字后，无论中英标点状态，句号自动半角
9. ……

## 可能会增加的功能

1. 候选栏颜色支持
2. ……

# LICENSE

Copyright (c) 2023 allandowney. 详情见 [LICENSE-MIT](LICENSE)
