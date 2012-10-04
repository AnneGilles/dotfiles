;; for linum-mode, if your distro does not have it (try M-x linum-mode)
;;(add-to-list 'load-path "~/.emacs.d/elisp")
;;(require 'linum)
;;
;; yes, I want column numbers mostly all of the time
(setq column-number-mode t)

;; column-marker.el
(require 'column-marker)
(add-hook 'flymake-mode-hook (lambda () (interactive) (column-marker-1 80)))


(when (load "flymake" t) 
  (defun flymake-pyflakes-init () 
    (let* ((temp-file (flymake-init-create-temp-buffer-copy 
		       'flymake-create-temp-inplace)) 
	   (local-file (file-relative-name 
			temp-file 
			(file-name-directory buffer-file-name)))) 
      (list "flake8" (list local-file)))) 
  
  (add-to-list 'flymake-allowed-file-name-masks 
	       '("\\.py\\'" flymake-pyflakes-init))
  (add-to-list 'flymake-allowed-file-name-masks 
	       '("\\.py.jinja\\'" flymake-pyflakes-init)
	       )) 

(defun my-flymake-show-help ()
  (when (get-char-property (point) 'flymake-overlay)
    (let ((help (get-char-property (point) 'help-echo)))
      (if help (message "%s" help)))))
(add-hook 'post-command-hook 'my-flymake-show-help)


(add-hook 'find-file-hook 'flymake-find-file-hook)
