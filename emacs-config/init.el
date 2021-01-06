(require 'package)
;;(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa-cn" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/"))
(add-to-list 'package-archives
	     '("org-cn" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/"))
(add-to-list 'package-archives
	     '("gnu-cn" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu"))


(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(org-babel-load-file "~/.emacs.d/config.org")

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
