;;; Commentary:
;; This contains my auctex/latex configuration
;; - Deepak Cherian

;;; Code:
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)

(setq TeX-source-correlate-method 'synctex)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)

(setq TeX-output-view-style
      (quote
       (("^pdf$" "." "evince -f %o")
        ("^html?$" "." "iceweasel %o"))))

;; Following from:
;; https://stackoverflow.com/questions/3627574/emacs-changing-the-default-reftex-citation
(defvar reftex-last-citation nil)

(defadvice reftex-citation (after reftex-citation-and-remember-citation activate)
  "Save last citation to 'reftex-last-citation after running 'reftex-citation"
  (setq reftex-last-citation ad-return-value))

(defadvice reftex-get-bibkey-default (around reftex-just-return-last-citation activate)
  "If there is a 'reftex-last-citation then just return that instead of running 'reftex-get-bibkey-default"
  (if reftex-last-citation
      (setq ad-return-value reftex-last-citation)
    ad-do-it))

(provide 'dc-latex)
;;; dc-latex.el ends here
