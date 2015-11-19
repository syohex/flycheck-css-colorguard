;;; flycheck-css-colorguard.el --- Detect similar colors in CSS

;; Copyright (C) 2015 Saša Jovanić

;; Author: Saša Jovanić <info@simplify.ba>
;; URL: https://github.com/simplify/flycheck-css-colorguard/
;; Version: 0.1.0
;; Keywords: flycheck, CSS
;; Package-Requires: ((flycheck "0.22") (emacs "24.4"))

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.


;;; Commentary:

;; This is extension for Flycheck.

;; From https://github.com/SlexAxton/css-colorguard:
;; CSS Colorguard helps you maintain the color set that you want, and warns
;; you when colors you've added are too similar to ones that already exist.

;; For more infomations about CSS Colorguard, please check the GitHub
;; https://github.com/SlexAxton/css-colorguard

;; For more information about Flycheck:
;; http://www.flycheck.org/
;; https://github.com/flycheck/flycheck

;; For more information about this Flycheck extension:
;; https://github.com/simplify/flycheck-css-colorguard


;;;; Setup

;; (eval-after-load 'flycheck
;;   '(progn
;;      (require 'flycheck-css-colorguard)
;;      (flycheck-add-next-checker 'css-csslint
;;                                 'css-colorguard 'append)))


;;;; CSS Colorguard output 1.0.0 or higher:
;;  line 2   col 3  #020202 collides with rgba(0,0,0,1)          (2:44)
;;  line 3   col 3  #000000 collides with rgba(0,0,0,1)          (2:44)
;;  line 3   col 3  #000000 collides with #020202                (2:59)
;;  line 7   col 3  black collides with rgba(0,0,0,1)            (2:44)
;;  line 7   col 3  black collides with #020202                  (2:59)
;;  line 12  col 3  rgb(0,0,0) collides with rgba(0,0,0,1)       (2:44)
;;  line 12  col 3  rgb(0,0,0) collides with #020202             (2:59)
;;  line 13  col 3  rgba(0,0,0,1) collides with #020202          (2:59)
;;  line 16  col 3  hsl(0,0%,0%) collides with rgba(0,0,0,1)     (2:44)
;;  line 16  col 3  hsl(0,0%,0%) collides with #020202           (2:59)
;;  line 17  col 3  hsla(0,0%,0%,1) collides with rgba(0,0,0,1)  (2:44)
;;  line 17  col 3  hsla(0,0%,0%,1) collides with #020202        (2:59)
;;  line 20  col 3  #010101 collides with rgba(0,0,0,1)          (2:44)
;;  line 20  col 3  #010101 collides with #020202                (2:59)
;;  line 52  col 5  #000000 collides with rgba(0,0,0,1)          (2:44)
;;  line 52  col 5  #000000 collides with #020202                (2:59)
;;  line 52  col 5  #000000 collides with #010101                (20:20)


;;; Code:

(require 'flycheck)

(flycheck-define-checker css-colorguard
  "Detect similar colors in CSS using CSS Colorguard.

See URL
`https://github.com/SlexAxton/css-colorguard'."
  :command ("colorguard" "--file" source)
  ;;(option "--threshold" "3")
	:error-patterns
	((warning line-start
            "  line " line (one-or-more " ") " col " column (one-or-more " ") (message) line-end))
  :modes (css-mode))

(add-to-list 'flycheck-checkers 'css-colorguard 'append)

(provide 'flycheck-css-colorguard)

;;; flycheck-css-colorguard.el ends here
