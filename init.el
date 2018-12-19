
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;这句话的意思是：告诉emacs要在HOME/emacs.d/elpa下查找package
;;(package-initialize)
;;(add-to-list 'custom-theme-load-path "~/.emacs.d/monokai-emacs/")
;;******************************************************************************

(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'init-packages)


(setq ring-bell-function 'ignore)

 ;; Find Executable Path on OS X
 (when (memq window-system '(mac ns))
   (exec-path-from-shell-initialize))



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

(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)


(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)


;可以在File中 Open Recent中看到最近打开的文件
;(recentf-mode t)
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 10)

;不备份文件
(setq make-backup-files nil)

;设置光标为线条状
(setq-default cursor-type `bar)

;;击活abbrev-mode后可以添加缩写,如按8dl后按空格则会自动补全成duanlangtaosha
;;8dl按/ 会变成duanlangtaosha/
(abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
					    ("8dl" "duanlangtaosha")))



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
 '(company-idle-delay 0.08)
 '(company-minimum-prefix-length 1)
 '(package-selected-packages (quote (company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "新宋体" :foundry "outline" :slant normal :weight normal :height 158 :width normal)))))



;C-h m可以查看当前buffer的Minor mode
;nil和-1有什么区别


;; ************************************************************************************************************
;;  ;;;###autoload  魔法注释
;; 当调用package-initialize 后会加载如companypackage中，的company-autoloads.el文件，这个文件是自动生成的一个文件
;; 也就是说在company的包中的其他的el文件中添加的魔法注释;;;###autoload后在编译后就会自动将魔法注释展开到一个“包
;; 各-autoload.el的文件中”，当调用package-initialize会执行"包名-autoload.el"文件

;; load-file 指定加载的文件，不需要emacs去猜
;; load      是让emacs去猜，比如指定了一个company，则emacs会根据load-path中的路径去找，找到后会先加载company.elc
;;           这个elc文件，如果没有elc的文件，则会去找company.el这个文件，如果还没有el这个文件就会报错

;; provide   一般文件末尾带有如：provide 'company-abbrev , 则是将company-abbrev这个符号放到了features的变量中
;; require   会去检查features这个变量，然后调用load函数去加载这个feature。如: require 'company-abbrev的时候会
;;           先到features中去找company-abbrev如果找到就调用load-file company-abbrev.elc,如果没有再找el文件
