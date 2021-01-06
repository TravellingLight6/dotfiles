(set-language-environment "UTF-8")
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-message t)
(setq inhibit-startup-screen t)
(setq make-backup-files nil)
(setq visible-bell t)
(defalias 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "<f6>") 'revert-buffer)

(use-package which-key
  :config
  (which-key-mode 1))
(use-package cnfonts
  :config
  (cnfonts-enable))

(use-package evil
  :config
  (evil-mode t))

(use-package evil-commentary
  :config
  (evil-commentary-mode))

(use-package ivy
  :ensure swiper
  :ensure counsel
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "C-x C-r") 'counsel-recentf)
  (global-set-key (kbd "C-x b") 'counsel-switch-buffer)
  (global-set-key (kbd "C-x C-b") 'counsel-bookmark)
  )

(use-package company
  :config
  (global-company-mode t))

(use-package yasnippet
  :config
  (yas-global-mode 1))

(use-package smartparens
  :config
  (require 'smartparens-config)
  (smartparens-global-mode)
  )

(use-package highlight-parentheses
  :config
  (global-highlight-parentheses-mode t))

(use-package magit)

(use-package hungry-delete
  :config
  (global-hungry-delete-mode))

(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(with-eval-after-load 'org       
  (setq org-startup-indented t) ; Enable `org-indent-mode' by default
  (add-hook 'org-mode-hook #'visual-line-mode))

(setq org-latex-pdf-process 
      '("xelatex -interaction nonstopmode %f"
	"xelatex -interaction nonstopmode %f")) ;; for multiple passes

(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)

(use-package org-journal
  :ensure t
  :defer t
  :config
  (setq org-journal-dir "~/Nutstore Files/Nutstore/org/journal"
        org-journal-file-format "%Y-%m-%d.org"
        org-journal-date-format "%A, %d %B %Y"))

(setq org-directory "~/Nutstore Files/Nutstore/org"
      org-default-notes-file (concat org-directory "/notes.org")
      org-default-dairy-file (concat org-directory "/dairy.org")
      org-default-gtd-file (concat org-directory "/agenda/gtd.org")
      )

(setq org-agenda-files '("~/Nutstore Files/Nutstore/org/agenda"))

(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "DONE(d!)" "CANCELED(c@)")))
(setq org-todo-keyword-faces
      '(("TODO" . org-warning) ("DONE" . "green")
        ("CANCELED" . (:foreground "blue" :weight bold))))

(defun org-journal-find-location ()
  ;; Open today's journal, but specify a non-nil prefix argument in order to
  ;; inhibit inserting the heading; org-capture will insert the heading.
  (org-journal-new-entry t)
  (unless (eq org-journal-file-type 'daily)
    (org-narrow-to-subtree))
  (goto-char (point-max)))

(setq org-capture-templates
      '(("t" "todo" entry (file org-default-gtd-file)
         "* TODO %?\nEntered on %U")
        ("d" "Diary" entry (file+olp+datetree org-default-dairy-file)
         "* %?\nEntered on %U")
        ("j" "Journal entry" plain (function org-journal-find-location)
         "** %?\nEntered on %U")
        ("i" "idea" entry (file+headline org-default-notes-file "Ideas")
         "* %? :IDEA:\nEntered on %U")
        ("n" "note" entry (file+headline org-default-notes-file "Notes")
         "* %? :NOTE:\nEntered on %U")
        ))

(setq org-refile-targets '((nil :maxlevel . 9)
                           (org-agenda-files :maxlevel . 9)))
(setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
(setq org-refile-use-outline-path t)                  ; Show full paths for refiling

(use-package deft
  :bind (("C-c d" . deft))
  :config
  (setq deft-recursive t)
  (setq deft-extensions '("txt" "tex" "org")
        deft-default-extension "org")
  (setq deft-directory "~/Nutstore Files/Nutstore/org"))
