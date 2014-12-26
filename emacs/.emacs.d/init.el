(load-theme 'manoj-dark t)

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

(defun gtags-parse-file2 ()
  (interactive)
  (if (gtags-get-rootpath)
      (let*
          ((root (gtags-get-rootpath))
           (path (buffer-file-name))
           (gtags-path-style 'root)
           (gtags-rootdir root))
        (if (string-match (regexp-quote root) path)
            (gtags-goto-tag
             (replace-match "" t nil path)
             "f" nil)
          ;; delegate to gtags-parse-file
          (gtags-parse-file)))
    ;; delegate to gtags-parse-file
    (gtags-parse-file)))
