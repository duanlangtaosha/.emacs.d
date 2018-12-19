
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;这句话的意思是：告诉emacs要在HOME/emacs.d/elpa下查找package
;;(package-initialize)
;;(add-to-list 'custom-theme-load-path "~/.emacs.d/monokai-emacs/")
;;******************************************************************************

(add-to-list 'load-path "~/.emacs.d/lisp")

;*************************************************************
;设置快捷键打开init.el文件，当按下F2后就会自动打开此文件
(defun open-my-init-file()
  ;必须设置为交互模式，才能在全局函数中找到open-my-init-file的函数
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(require 'init-packages)
(require 'init-ui)
(require 'init-better-default)
(require 'init-keybindings)

;; 将软件自动生成的配置放到lisp/custom.el文件中
(setq custom-file (expand-file-name "lisp/custom.el" user-emacs-directory))

(load-file custom-file)
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
