;; 起動直後のfind-fileのパスを設定する
; 初期ディレクトリの設定
; (cd "~/shared/ProjectData/")

;; input method
(setq  default-input-method "MacOSX")

;; load library
(setq load-path (cons "~/Library/emacs" load-path))
(setq load-path (cons "~/Library/emacs/color-theme/color-theme-6.6.0" load-path))
(setq load-path (cons "~/Library/emacs/html-helper-mode" load-path))

;; auto-complete-config
(add-to-list 'load-path "/Users/yokoi-h/.emacs.d/auto-complete-config")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/Users/yokoi-h/.emacs.d/auto-complete-config/ac-dict")
(ac-config-default)


;; html-helper-mode
(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
(setq auto-mode-alist (cons '("\\.html$" . html-helper-mode) auto-mode-alist))


;; Color theme
(require 'color-theme)
  (eval-after-load "color-theme"
    '(progn
      (color-theme-initialize)
      (color-theme-hober)))

;; Font Settings
(if (eq window-system 'ns) (progn
(create-fontset-from-ascii-font "Menlo-15:weight=normal:slant=normal" nil "menlokakugo")
(set-fontset-font "fontset-menlokakugo" 'unicode (font-spec :family "Hiragino Kaku Gothic ProN" :size 16 ) nil 'append)
(add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))
(setq face-font-rescale-alist '((".*Hiragino.*" . 1.2) (".*Menlo.*" . 1.0)))))


;; 起動直後のfind-fileのパスを設定する
; 初期ディレクトリの設定
(cd "/Users/yokoi-h/Documents")

(add-to-list 'load-path "~/.emacs.d/emacs-deferred")
(add-to-list 'load-path "~/.emacs.d/emacs-epc")
(add-to-list 'load-path "~/.emacs.d/emacs-ctable")
(add-to-list 'load-path "~/.emacs.d/emacs-jedi")
(require 'python)
(require 'jedi)

(add-hook 'python-mode-hook 'jedi:setup)
;;これを入れるとjediを手動<C-tab>で立ち上げないといけない。
;(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)

(defun jedi:stop-all-servers ()
  (maphash (lambda (_ mngr) (epc:stop-epc mngr))
           jedi:server-pool--table))

(add-hook 'kill-emacs-hook #'jedi:stop-all-servers)
