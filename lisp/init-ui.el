
;(linum-mode t)

;关闭开启软件启动界面
(setq inhibit-splash-screen t)

;关闭左边的托动条
(scroll-bar-mode -1)

;注释缩进关闭
(electric-indent-mode -1)

;输入括号时自动添加半边括号
(electric-pair-mode t)



;当在外部修改了init.el会自动加载init.el文件
(global-auto-revert-mode t)

;设置光标为线条状
(setq-default cursor-type `bar)

;关闭tool-bar
(tool-bar-mode 0)

;开启emacs后全屏显示
(setq initial-frame-alist (quote ((fullscreen . maximized))))
(provide 'init-ui)
