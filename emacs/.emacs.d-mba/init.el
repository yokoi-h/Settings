(load-theme 'adwaita t)

(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)


;;; load-pathを追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
     (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
         (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
             (normal-top-level-add-subdirs-to-load-path))))))

;;; ディレクトリをサブディレクトリごとload-pathに追加
(add-to-load-path "elisp")

(autoload 'gtags-mode "gtags" "" t)
(setq gtags-mode-hook
      '(lambda ()
         (local-set-key "\M-t" 'gtags-find-tag)
         (local-set-key "\M-r" 'gtags-find-rtag)
         (local-set-key "\M-s" 'gtags-find-symbol)
         (local-set-key "\C-t" 'gtags-pop-stack)
         ))

(add-hook 'c-mode-common-hook
          '(lambda()
             (gtags-mode 1)
             (gtags-make-complete-list)
             ))
;;; go-mode
(require 'go-mode)
(add-to-list 'exec-path (expand-file-name "~/workspace/go/bin"))
(defun my-go-mode-hook ()
  ; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'my-go-mode-hook)

;;emacs_nav
(require 'nav)
(defun nav-mode-hl-hook ()
  (local-set-key (kbd "<right>") 'nav-open-file-under-cursor)
  (local-set-key (kbd "<left>")  'nav-go-up-one-dir)
  )

(add-hook 'nav-mode-hook 'nav-mode-hl-hook)

(require 'go-autocomplete)
(require 'auto-complete-config)

(global-set-key (kbd "C-x C-b") 'bs-show)

(xterm-mouse-mode t)
(mouse-wheel-mode t)
(global-set-key   [mouse-4] '(lambda () (interactive) (scroll-down 1)))
(global-set-key   [mouse-5] '(lambda () (interactive) (scroll-up   1)))

;;grep-find
(global-set-key (kbd "C-x /") 'grep-find)
;;mouse-mode
(global-set-key (kbd "C-x ,") 'xterm-mouse-mode)
;;backward
(global-set-key (kbd "s-[") 'pop-global-mark)
;;auto-complete-mode
(global-set-key (kbd "C-x \\") 'auto-complete-mode)

;;font settings
(when window-system
  (create-fontset-from-ascii-font "Source Code Pro-16:weight=normal:slant=normal" nil "codekakugo")
  (set-fontset-font "fontset-codekakugo"
		    'unicode
		    (font-spec :family "Hiragino Kaku Gothic Pro" :size 16)
		    nil
		    'append)
  (add-to-list 'default-frame-alist '(font . "fontset-codekakugo"))
  )

;;path settings
(setenv "PATH" "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/go/bin:/usr/local/go/bin:/usr/local/apache-ant-\
1.9.4/bin")
(dolist (path (reverse (split-string (getenv "PATH")":")))
  (add-to-list 'exec-path path))
