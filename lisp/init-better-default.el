
;; 关闭响声
(setq ring-bell-function 'ignore)

;选中后输入就将选中的以输入的替换了
(delete-selection-mode t)

;设置行号，如果不加global可能不能显示行号
(global-linum-mode t)

;;击活abbrev-mode后可以添加缩写,如按8dl后按空格则会自动补全成duanlangtaosha
;;8dl按/ 会变成duanlangtaosha/
(abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
					    ("8dl" "duanlangtaosha")))

;; 禁止备份文件
(setq make-backup-files nil)

;; 禁止自动保存
(setq auto-save-default nil)

;可以在File中 Open Recent中看到最近打开的文件
;;设置快捷键调用C-x C-r就可以显示最近打开的文件
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

;(popwin-mode t )会自动将光标移动到新打开的窗口，按q或者C-g会自动关掉，还没有下载package

;与在Options-Highlighting Matching Paren 一样的效果
;add-hook添加一个勾子，添加到emacs-lisp-mode-hook上
;这句话的意思是：当打开文件后会击活emacs-lisp-mode的major mode
;击活后会运行其所有的勾子，则加的show-paren-mode的勾子就会生效
(add-hook `emacs-lisp-mode-hook `show-paren-mode)

(provide 'init-better-default)
