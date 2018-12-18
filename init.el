
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;这句话的意思是：告诉emacs要在HOME/emacs.d/elpa下查找package
;;(package-initialize)
;;(add-to-list 'custom-theme-load-path "~/.emacs.d/monokai-emacs/")
;;******************************************************************************

(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.milkbox.net/packages/") t)


;;(when (>= emacs-major-version 24)
;;    (require 'package)
;;    (package-initialize)
;;   (add-to-list 'package-archives '("melpa" . "http://elpa.emacs-china.org/melpa/") t)
;;    )
    
     (when (>= emacs-major-version 24)
     (require 'package)
     (package-initialize)
     (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
		      ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

;; 注意 elpa.emacs-china.org 是 Emacs China 中文社区在国内搭建的一个 ELPA 镜像

 ;; cl - Common Lisp Extension
 (require 'cl)

 ;; Add Packages
 (defvar my/packages '(
		;; --- Auto-completion ---
		company
		;; --- Better Editor ---
		hungry-delete
		swiper
		counsel
		smartparens
		;; --- Major Mode ---
		js2-mode
		;; --- Minor Mode ---
		nodejs-repl
		exec-path-from-shell
		;; --- Themes ---
		monokai-theme
		;; solarized-theme
		) "Default packages")

 (setq package-selected-packages my/packages)

 (defun my/packages-installed-p ()
     (loop for pkg in my/packages
	   when (not (package-installed-p pkg)) do (return nil)
	   finally (return t)))

 (unless (my/packages-installed-p)
     (message "%s" "Refreshing package database...")
     (package-refresh-contents)
     (dolist (pkg my/packages)
       (when (not (package-installed-p pkg))
	 (package-install pkg))))

 ;; Find Executable Path on OS X
 (when (memq window-system '(mac ns))
   (exec-path-from-shell-initialize))

;只有安装了相应的company包后才能使用
(global-company-mode t)

;设置行号，如果不加global可能不能显示行号
(global-linum-mode t)
;(linum-mode t)

;关闭开启软件启动界面
(setq inhibit-splash-screen t)

;关闭左边的托动条
(scroll-bar-mode -1)

;注释缩进关闭
(electric-indent-mode -1)

;输入括号时自动添加半边括号
(electric-pair-mode t)

;选中后输入就将选中的以输入的替换了
(delete-selection-mode t)

;开启emacs后全屏显示
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;当在外部修改了init.el会自动加载init.el文件
(global-auto-revert-mode t)

;添加多个空格一下就删除了
;(global-hungry-delete-mode)

;(popwin-mode t )会自动将光标移动到新打开的窗口，按q或者C-g会自动关掉，还没有下载package

;与在Options-Highlighting Matching Paren 一样的效果
;add-hook添加一个勾子，添加到emacs-lisp-mode-hook上
;这句话的意思是：当打开文件后会击活emacs-lisp-mode的major mode
;击活后会运行其所有的勾子，则加的show-paren-mode的勾子就会生效
(add-hook `emacs-lisp-mode-hook `show-paren-mode)

;;当前行高亮
(global-hl-line-mode t)

;可以在File中 Open Recent中看到最近打开的文件
;(recentf-mode t)

;不备份文件
(setq make-backup-files nil)

;设置光标为线条状
(setq-default cursor-type `bar)
;*************************************************************
;设置快捷键打开init.el文件，当按下F2后就会自动打开此文件
(defun open-my-init-file()
  ;必须设置为交互模式，才能在全局函数中找到open-my-init-file的函数
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;将函数的快捷键绑定到F2
(global-set-key (kbd "<f2>") `open-my-init-file)
;*************************************************************

;*************************************************************
;设置快捷键调用C-x C-r就可以显示最近打开的文件
(require `recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" `recentf-open-files)
;*************************************************************

;自动设置的，新宋体，字号
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "新宋体" :foundry "outline" :slant normal :weight normal :height 158 :width normal)))))


;C-h m可以查看当前buffer的Minor mode
;nil和-1有什么区别
