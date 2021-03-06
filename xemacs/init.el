;;;		-*- Mode: emacs-lisp -*-
;;;
;;;    .emacs file for Thomas R. Corbin
;;;
;;;    $Id: init.el,v 1.1 2002/07/17 18:18:44 tc Exp tc $
;;;
;;;


;; frame-background-mode

(setq lpr-command "a2ps")


;; Get rid of that annoying prompt that requires one to type
;; in Y-E-S and then press the friggin enter key to confirm.
(defun yes-or-no-p (PROMPT)
  (beep)
  (y-or-n-p PROMPT))



;; Enable dictionary mode (dictionary.el).  With this, you can do a
;;  M-x dictionary-search and search a number of free
;;  dictionaries on the web for a definition.  Works great.
;; http://www.in-berlin.de/User/myrkr/dictionary.html
;    (autoload 'dictionary-search "dictionary"
;      "Ask for a word and search it in all dictionaries" t)
;    (autoload 'dictionary-match-words "dictionary"
;      "Ask for a word and search all matching words in the dictionaries" t)
;    (autoload 'dictionary "dictionary"
;      "Create a new dictionary buffer" t)
;    ;; Assign keyboard shortcuts C-c s and C-c m.
;    (global-set-key "\C-cs" 'dictionary-search)
;    (global-set-key "\C-cm" 'dictionary-match-words)


;;;  Only true on my linux box.
;;;(setq Info-directory-list '(/usr/info/dir) )


;;;  More info
;;(setq Info-default-directory-list
;;    (append Info-default-directory-list '("/home/tc/misc/info/")))


;;;  Ignore .la, .a, .lo files
(setq completion-ignored-extensions
    (append completion-ignored-extensions '(".lo" ".la" ".a")))


(setq require-final-newline t)

;;;
;;; Define a variable to indicate whether we're running XEmacs/Lucid Emacs.
;;; (You do not have to defvar a global variable before using it --
;;; you can just call `setq' directly like we do for `emacs-major-version'
;;; below.  It's clearer this way, though.)
;;; 
;;(defvar running-xemacs (string-match "XEmacs\\|Lucid" emacs-version))
 
;;; (setq gdb-command-name "/home/clkkmaq/bin/gdb")


;;;
;;;  from Paul Nakada <xrxedds!uunet!us.oracle.com!pnakada>
;;;
(if (and window-system (x-display-color-p))
(progn

    ;;;
    ;;; Make the mark hilight
    ;;;
    ;; (transient-mark-mode t)
    (setq highlight-nonselected-windows nil)


    (cond (running-xemacs

           (gnuserv-start)


          ;; Change the cursor used during garbage collection.
          ;;
          ;; Note that this cursor image is rather large as cursors go,
          ;; and so it won't work on some X servers (such as the MIT
          ;; R5 Sun server) because servers may have lamentably small
          ;; upper limits on cursor size.
          ;;(if (featurep 'xpm)
          ;;   (setq x-gc-pointer-shape
          ;;         (expand-file-name "trash.xpm" data-directory)))

          ;; Here's another way to do that: it first tries to load the
          ;; cursor once and traps the error, just to see if it's
          ;; possible to load that cursor on this system; if it is,
          ;; then it sets x-gc-pointer-shape, because we knows that
          ;; will work.  Otherwise, it doesn't change that variable
          ;; because we know it will just cause some error messages.
          (if (featurep 'xpm)
              (let ((file (expand-file-name "recycle.xpm" data-directory)))
                (if (condition-case error
                        (make-cursor file) ;returns a cursor if successful.
                      (error nil))      ; returns nil if an error occurred.
                    (setq x-gc-pointer-shape file))))


          ;; Add `dired' to the File menu
          ;; (add-menu-item '("File") "Edit Directory" 'dired t)

          ;; Here's a way to add scrollbar-like buttons to the menubar
          ;;; (add-menu-item nil "Top" 'beginning-of-buffer t)
          ;;; (add-menu-item nil "<|" 'c++-beginning-of-defun t)
          ;;; (add-menu-item nil "<<<" 'scroll-down t)
          ;; (add-menu-item nil " . " 'recenter t)
          ;;; (add-menu-item nil ">>>" 'scroll-up t)
          ;;; (add-menu-item nil "|>" 'c++-end-of-defun t)
          ;;; (add-menu-item nil "Bot" 'end-of-buffer t)
          ;;; (add-menu-item nil "X" 'server-edit t)


          ;; Change the behavior of mouse button 2 (which is normally
          ;; bound to `mouse-yank'), so that it inserts the selected text
          ;; at point (where the text cursor is), instead of at the
          ;; position clicked.
          ;;
          ;; Note that you can find out what a particular key sequence or
          ;; mouse button does by using the "Describe Key..." option on
          ;; the Help menu.
          (setq mouse-yank-at-point t)


          ;; When editing C code (and Lisp code and the like), I often
          ;; like to insert tabs into comments and such.  It gets to be
          ;; a pain to always have to use `C-q TAB', so I set up a more
          ;; convenient binding.  Note that this does not work in
          ;; TTY frames.
          (define-key global-map '(shift tab) 'self-insert-command)

        ))

    (setq  auto-raise-screen nil)

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; buffer hilighting
    ;;
;;    (cond (window-system
;;	(setq hilit-mode-enable-list	'(not text-mode)
;;		hilit-background-mode   'dark
;;		hilit-inhibit-hooks     nil
;;		hilit-auto-hilight	t
;;		hilit-inhibit-rebinding nil)
;;    ))

    ))


    ;;  Get parens to blink/hilite.
    (load "paren")
    (setq paren-ding-unmatched t)
    (setq paren-mode 'sexp)
    (setq parens-require-spaces t)
    (setq buffers-menu-max-size nil)


    ;;  I like the yes no dialogs to pop up.
    ;; (require 'dialog-y-n)

    ;; don't include system name in screen titles
    (setq include-system-name nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  End of all the "(if (and window-system (x-display-color-p))"


(mwheel-install)
(setq mwheel-follow-mouse t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;    python outline mode
;;

(defvar outline-start-hidden t "Start outline hidden")

(defun outline-setup (regexp)
  "Setup outline mode"
  (defvar outline-toggle-all-flag nil "toggle all flag")
  (defvar cpos_save nil "current cursor position")
  (outline-minor-mode)
  (setq outline-regexp regexp)
  (define-key outline-minor-mode-map "\C-c\C-e" 'outline-toggle-entry)
  (define-key outline-minor-mode-map "\C-c\C-a" 'outline-toggle-all)
  (if outline-start-hidden
      (hide-body))

  (defun outline-toggle-entry () (interactive)
    "Toggle outline hiding for the entry under the cursor"
    (if (progn
          (setq cpos_save (point))
          (end-of-line)
          (get-char-property (point) 'invisible))
        (progn 
          (show-subtree)
          (goto-char cpos_save))
      (progn 
        (hide-leaves)
        (goto-char cpos_save))))
        
  (defun outline-toggle-all () (interactive)
    "Toggle outline hiding for the entire file"
    (if outline-toggle-all-flag
        (progn
          (setq outline-toggle-all-flag nil)
          (hide-body))
      (progn 
        (setq outline-toggle-all-flag t)
        (show-all))))
)

(defun python-outline () (interactive)
  "Python outline mode"
  (python-mode)
  (outline-setup "^class \\|[   ]*def \\|^#"))

(defun texi-outline () (interactive)
  "Texinfo outline mode"
  (texinfo-mode)
  (outline-setup "^@chap\\|@\\(sub\\)*section"))




;
;  Find file at point.
;
;;(autoload 'find-file-at-point "ffap" nil t)
;;(define-key global-map [(f3)] 'find-file-at-point)

;;(require 'jka-compr)
;;(require 'ci-mode)



;;; (load "gid.el")

;;;
;;;	Vc mode.
;;;
;;;(load-file "/usr/gnu/lib/emacs/site-lisp/vc.el")
(setq vc-command-messages t)
(setq vc-mistrust-permissions nil)
;;;(setq vc-path '("/home/clkkmaq/gnu/bin"))

;;(setq cvs-program "/usr/bin/cvs")




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; add the pcl-cvs directory to my path
;;(setq load-path 
;;      (nconc '("~/misc/elisp/pcl-cvs")
;;	     load-path))

;; Pcl-CVS
;;(autoload 'cvs-examine "pcl-cvs" nil t)
;;(autoload 'cvs-update "pcl-cvs" nil t)
;; (setenv "CVS_RSH" "/usr/bin/ssh")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;
;;;  From Xemacs
;;;
(add-hook 'shell-mode-hook 'install-shell-fonts) 


;;;
;;;	Electric c mode preferences.
;;;
(fmakunbound 'c-mode)
(makunbound 'c-mode-map)
(fmakunbound 'c++-mode)
(makunbound 'c++-mode-map)
(makunbound 'c-style-alist)



;;;
;;;  The "new" cc-mode stuff
;;;
(setq font-lock-use-colors t)

(setq font-lock-use-fonts t)
(setq font-maximum-decoration t)
(setq font-lock-use-maximal-decoration t)
(setq font-lock-use-maximum-decoration t)
;;; (setq font-lock-mode-enable-list '((ci-mode) (dired)))
(setq font-lock-verbose t)

(load-library "font-lock")
;;(load-library "dired-chmod")
(load-library "view-less")

(add-hook 'find-file-hooks 'auto-view-mode)

;;;(load-library "dired-xemacs-highlight")
;;(require 'dired-xemacs-highlight)

;;(setq dired-do-permission-highlighting-too t)





;; comments are italic and red; doc strings are italic
;;
;; (I use copy-face instead of make-face-italic/make-face-bold
;; because the startup code does intelligent things to the
;; 'italic and 'bold faces to ensure that they are different
;; from the default face.  For example, if the default face
;; is bold, then the 'bold face will be unbold.)
(copy-face 'italic 'font-lock-comment-face)
;; Underling comments looks terrible on tty's
(set-face-underline-p 'font-lock-comment-face nil 'global 'tty)
(set-face-highlight-p 'font-lock-comment-face t 'global 'tty)
(copy-face 'font-lock-comment-face 'font-lock-doc-string-face)
(set-face-foreground 'font-lock-comment-face "red")

;; string face is green
(set-face-foreground 'font-lock-string-face "forest green")

;; function names are bold and blue
(copy-face 'bold 'font-lock-function-name-face)
(set-face-foreground 'font-lock-function-name-face "blue")

;; misc. faces
(and (find-face 'font-lock-preprocessor-face) ; 19.13 and above
    (copy-face 'bold 'font-lock-preprocessor-face))
;;;(copy-face 'italic 'font-lock-type-face)
;;;(copy-face 'bold 'font-lock-keyword-face)
(set-face-foreground 'font-lock-keyword-face "blue")
(set-face-foreground 'font-lock-type-face "blue")

    ;;(add-to-list 'load-path (expand-file-name "~/misc/elisp/jde-2.2.9beta10/lisp"))
    ;;(add-to-list 'load-path (expand-file-name "~/misc/elisp/jde-2.2.9beta12/lisp"))
    ;;(add-to-list 'load-path (expand-file-name "~/misc/elisp/jde-2.2.7.1/lisp"))
    ;;(add-to-list 'load-path (expand-file-name "/usr/share/emacs/site-lisp/semantic"))


(add-to-list 'load-path (expand-file-name "~/misc/elisp"))
(add-to-list 'load-path (expand-file-name "~/misc/elisp/jde-2.3.1/lisp"))
(add-to-list 'load-path (expand-file-name "~/misc/elisp/semantic-1.4beta14"))

(add-to-list 'load-path (expand-file-name "/usr/share/emacs/site-lisp/speedbar"))
(add-to-list 'load-path (expand-file-name "~/misc/elisp/elib"))
(add-to-list 'load-path (expand-file-name "/usr/share/emacs/site-lisp/eieio"))
 
;;(require 'jde)
;;(require 'jde-check)
    ;(require 'jsee)

    ;;(setq load-path (cons "/usr/share/emacs/site-lisp" load-path))
    ;;(setq load-path (cons "/usr/share/emacs/site-lisp/elib" load-path))
    ;;(setq load-path (cons "/usr/share/emacs/site-lisp/eieio" load-path))
    ;;(setq load-path (cons "/usr/share/emacs/site-lisp/speedbar" load-path))
    ;;(setq load-path (cons "/usr/share/emacs/site-lisp/semantic" load-path))
    ;;(setq load-path (cons "/usr/share/emacs/site-lisp/jde" load-path))


;;(require 'force-space)
;;(require 'code-keywords)
;;(require 'tab-display)

(setq shell-file-name "bash")


(autoload 'c++-mode "cc-mode" "C++ Editing Mode" t)
(autoload 'c-mode   "cc-mode" "C Editing Mode" t)


(setq font-lock-maximum-decoration t)


(autoload 'java-mode "cc-mode" "Java Editing Mode" t)
;;(autoload 'ruby-mode "ruby-mode" "Ruby Editing Mode" t)

(setq auto-mode-alist
      (append '(("\\.C$"  . c++-mode)
		("\\.cc$" . c++-mode)
		("\\.cpp$" . c++-mode)
		("\\.rb$"  . ruby-mode)   ; to edit ruby code
		("\\.c$"  . c-mode)   ; to edit C code
		("\\.m$"  . ci-mode)   ; to edit macro code
		("\\.cs$"  . java-mode)   ; to edit C# code
		("\\.proto$"  . ci-mode)   ; to edit macro code
		("\\.ims$"  . ci-mode)   ; to edit macro code
		("\\.h$"  . c++-mode)   ; to edit C++ code
		("\\.pl$"  . perl-mode)   ; to edit perl code
		("akefile$"  . makefile-mode)   ; to edit makefiles
		("\\.mk$"  . makefile-mode)   ; to edit makefiles
		("\\.java$"  . jde-mode)   ; to edit java code
		("\\.xpm$"  . xpm-mode)   ; to edit xpm files
		) auto-mode-alist))


;;;  ruby
(setq ruby-indent-level 4)

         ;;;; ("\\.sql$"  . sql-mode)   ; to edit sql
        ;;;; (c-set-offset 'substatement-open +)
        ;;; (message "executing my-c-mode-common-hook")
        ;;; (c-set-offset 'access-label +)

    (defun my-c-mode-common-hook ()
        (c-set-offset 'substatement 4)
        (c-set-offset 'substatement-open 0)
        (c-set-offset 'case-label 4)
        (c-set-offset 'statement-case-intro 4))
    (add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

                ;;; (setq substatement-open +)

                ;;; (message "executing c-mode-common-hook")

    (add-hook 'c-mode-common-hook
	  '(lambda ()
                (setq c-basic-offset 4)
                (c-set-offset 'substatement-open 0)
                (define-key c-mode-map "\C-j"      'newline-and-indent)
	     ))


(defconst my-java-style
  '("TC"
    (c-basic-offset . 4)
    (c-offsets-alist . ((inline-open . 0)
                        (substatement-open . 0)))
    )
  "My Java style")

;; Customizations for both c-mode and c++-mode
(defun my-java-mode-hook ()
  ;; set up for my perferred indentation style, but  only do it once
  (let ((my-style "TC"))
    (or (assoc my-style c-style-alist)
	(setq c-style-alist (cons my-java-style c-style-alist)))
    (c-set-style my-style))
  ;; offset customizations not in my-style
  (c-set-offset 'member-init-intro (* 2 c-basic-offset))
  (c-set-offset 'case-label 4)

  ;; other customizations
  ;; we like auto-newline and hungry-delete
  ;; (c-toggle-auto-hungry-state 1)
  ;; keybindings for C, C++, and Objective-C.  We can put these in
  ;; c-mode-map because c++-mode-map and objc-mode-map inherit it
  (define-key c-mode-map "\C-m" 'newline-and-indent)
  )
;; the following only works in Emacs 19
;; Emacs 18ers can use (setq c-mode-common-hook 'my-c-mode-common-hook)

(add-hook 'java-mode-hook 'my-java-mode-hook)

        (setq font-lock-keywords-ci-mode
          (list "if"
                "else"
                "macro"
                "locals"
                "vset"
                "lset"
                "//"
                "set"
                "return"
                "mesgc"
                "mesg"
                "usage"
                "continue"
                "break"
                "foreachobject"
                "foreach"
                "then" ))

;;                     (setq tab-width 4)

	(add-hook 'ci-mode-hook
                  '(lambda ()
                     (setq font-lock-keywords font-lock-keywords-ci-mode)
                     (turn-on-font-lock)
                     ))

	;; (add-hook 'dired-mode-hook       'direc-xemacs-highlight)
	;; (add-hook 'dired-after-readin-hook 'dired-permissions-highlight)



;;          (list (cons "if" )
;;                (cons "else" )
;;                (cons "macro" )
;;                (cons "usage" )
;;                (cons "foreach" )
;;                (cons "then" )))







(setq ci-indent-offset 4)
(setq ci-body-indent 4)

;;
;;    KSH stuff
;;
(setq ksh-indent 4)
(setq ksh-case-item-offset 4)
(setq ksh-group-offset -4)

;;
;;    PERL stuff
;;
;;(setq perl-tab-always-indent t)
;;(setq perl-tab-to-comment nil)
(setq perl-indent-level 4)
(setq perl-continued-statement-offset 0)
(setq perl-continued-brace-offset 0)
(setq perl-brace-offset 0)
(setq perl-label-offset -2)



(setq c-echo-semantic-information-p t)
(setq c-echo-syntactic-information-p t)
(setq c-auto-newline nil)
(setq c-indent-level 4)
(setq c-continued-statement-offset 0)
(setq c-brace-offset 0)
(setq c-basic-offset 4)
(setq c-label-offset -2)
(setq c++-electric-colon nil)
(setq c++-member-init-indent 8)
(setq c++-continued-member-init-offset 8)



(setq c-tab-always-indent t)



;;;
;;;	General Preferences.
;;;
(setq make-backup-files nil)
(setq-default case-fold-search nil)
(setq-default indent-tabs-mode nil)
(global-set-key "="  'what-line)



;;;
;;;	NO visible bell.
;;;
(setq visible-bell nil)


;;;(setq default-major-mode 'text-mode)

(add-hook 'text-mode-hook 'turn-on-auto-fill)

;;;
;;;	Show the time
;;;
;;(load-file "/home/tc/misc/elisp/time.el")
;;(display-time)

;(require 'balloon-help)
;(setq balloon-help-mode t)
(setq line-number-mode t)
;;(setq display-time-day-and-date t)
;(setq display-time-balloon-show-mail-from t)


;;;
;;;	Try a compile.
;;;
;;;(setq compile-command "make -k CDEBUG=-g install")


(setq compile-command "gm -k")


(defun compile-install ()
    "Perform a compile with last target."
    (interactive)
    (compile compile-command ))

;;(setq cfile-hdr     "/net/hal/home/tc/misc/template/cfile.hdr")
;;(setq cfunction-hdr "/net/hal/home/tc/misc/template/cfunction.hdr")

;;;
;;;	Insert a c file header.
;;;
;(defun insert-cfile-hdr ()
;    "Insert a c file header."
;    (interactive)
;    (insert-file cfile-hdr))

;;;
;;;	Insert a c function header.
;;;
;(defun insert-cfunction-hdr ()
;    "Insert a c function header."
;    (interactive)
;    (insert-file cfunction-hdr))

;;;
;;;	Insert date into file at pointer.
;;;
(defun insert-date ()
    "Insert date into file at pointer."
    (interactive)
    (setq day (substring (current-time-string) 0 3))
    (setq moday (substring (current-time-string) 4 10))
    (setq year (substring (current-time-string) 20 24))
    (insert day ", " moday " " year))


(defun insert-tccomment ()
    "Insert a tc comment, including date."
    (interactive)
    (setq day (substring (current-time-string) 0 3))
    (setq moday (substring (current-time-string) 4 10))
    (setq year (substring (current-time-string) 20 24))
    (setq hh (substring (current-time-string) 11 14))
    (insert "// (tc) " moday ", " year " at " hh "00 - " )
    (c-indent-command)
    )


(defalias 'format-javadoc (read-kbd-macro
"C-r ** C-e RET C-s */ C-a RET 2*<C-p> ESC q C-s */ C-a C-p C-k C-r ** C-e C-k"))



(defun runAllTests ()
    "run the AllTests junit test."
    (interactive)
    (shell-command "java $(package).AllTests" nil))

(defun insert-logger ()
    "Insert a logger w/test."
    (interactive)
    (insert "\n        if ( logger.isInfoEnabled() )\n        {\n            logger.info();\n        }\n" )
    (c-indent-command)
    )


;;;
;;;	Source in abbreviation file
;;;
;;; (read-abbrev-file "~/.abbrev_defs")
;(setq-default abbrev-mode t)
;(setq save-abbrevs t)


;;
;; Because I have so many screens open all the time, and idle C-xC-c can
;; really screw things up for me.  So make sure we dont exit without
;; confirmation, and rebind C-xC-c appropriately.
;;
(defun my-exit-from-emacs ()
  (interactive)
  (if (yes-or-no-p "Do you want to exit ")
      (save-buffers-kill-emacs)))

(global-set-key "\C-x\C-c" 'my-exit-from-emacs)

;;;
;;;	Enable Esc-Esc evaluation.
;;;
(put 'eval-expression 'disabled nil)

;;;
;;;	Set the tags file name.
;;;
;;; (setq tags-file-name "/home/tc/misc/src/ClearSpace/src/TAGS")
;;(setq tags-file-name "/home/tc/ClearSpace/src/TAGS")

;;;
;;;	Tell mh-e.el where the mh progs and libs are.
;;;
;;(setq mh-progs "/opt/IMS/mh/bin")
;;(setq mh-lib   "/opt/IMS/mh/lib/")


(defalias 'add-java-comment
  (read-kbd-macro "C-u ESC ! javaComment RET"))

(defalias 'add-java-attr
  (read-kbd-macro "C-u ESC ! javaAttr RET"))


(defalias 'kill-extra-space
  (read-kbd-macro "C-j ESC ^"))




;;;
;;;	Assign useful keyboard shortcuts.
;;;
;;; (global-set-key  ')
;;;(global-set-key [(control H)]   'backward-delete-char-untabify)
(global-set-key "\C-h" 'delete-backward-char)
;;(global-unset-key " ")
(global-set-key "\C-xh" 'help-command) ; override mark-whole-buffer
(global-set-key "\C-/" 'comment-region)
(global-set-key "\C-\\" 'uncomment-region)

;;(global-unset-key "\A-b")
(global-set-key [f1]  'kill-extra-space)
(global-set-key [f2]  'goto-line)
(global-set-key [f3]  'add-java-comment)
;;(global-set-key [f4]  'insert-date)
;;(global-set-key [f4]  'jde-complete-at-point-menu)
(global-set-key [f4]  'add-java-attr)
(global-set-key [f5]  'insert-tccomment)
(global-set-key [f6]  'compile-install)
(global-set-key [f7]  'next-error)
(global-set-key [f8]  'kill-compilation)

;;    f9/f10/f11 swallowed by window manager
;;(global-set-key [f9]  'force-space)
(global-set-key [f12]  'insert-logger)
;;(global-set-key [f11] 'other-window)		;;; Stop - twm - plays kirk
;;(global-set-key [f12] 'describe-key)	;;; Again


;;
;;    These work on my thinkpad.  They are the keys on the left and
;;    The forwards, backwards pages keys by the inverted T arrow keys.
;;
(global-set-key [f13] 'switch-frame)
(global-set-key [f14] 'delete-frame)
(global-set-key [f15] 'abbrev-mode)
(global-set-key [f16] 'load-my-emacs)
(global-set-key [f17] 'hold-region)
(global-set-key [f18] 'lookup-word)
(global-set-key [f19] 'mh-rmail)
(global-set-key [f20] 'mh-smail)





(global-set-key [f21] 'backward-word)		;;; 
(global-set-key [f22] 'beginning-of-defun)
(global-set-key [f23] 'forward-word)
(global-set-key [f24] 'beginning-of-buffer)
(global-set-key [f25] 'end-of-defun)
(global-set-key [f26] 'end-of-buffer)
(global-set-key [f27] 'beginning-of-defun)	;;; 7
(global-set-key [kp-7] 'beginning-of-defun)	;;; 7
;;;(global-set-key [f28] 'previous-line)
(global-set-key [f29] 'end-of-defun)		;;; 9
(global-set-key [kp-9] 'end-of-defun)		;;; 9
;;;(global-set-key [f30] 'end-of-buffer)
(global-set-key [f31] 'recenter)		;;; 5
(global-set-key [kp-5] 'recenter)		;;; 5
(global-set-key [kp-begin] 'recenter)		;;; 5
;;;(global-set-key [f32] 'forward-char)
(global-set-key [f33] 'beginning-of-buffer)	;;; 1
(global-set-key [kp-1] 'beginning-of-buffer)	;;; 1
;;;(global-set-key [f34] 'next-line)
(global-set-key [f35] 'end-of-buffer)		;;; 3
(global-set-key [kp-3] 'end-of-buffer)		;;; 3
(global-set-key [home] 'beginning-of-buffer)	;;; 1
(global-set-key [end] 'end-of-buffer)		;;; 3


;;(autoload 'gnus-grab-gif "~/elisp/gif" "" t)
;;(autoload 'uuencode-file "~/elisp/uu" "" t)
;;(autoload 'uuencode-buffer "~/elisp/uu" "" t)
;;(autoload 'uuencode-region "~/elisp/uu" "" t)
;;(autoload 'uudecode-buffer "~/elisp/uu" "" t)
;;(autoload 'uudecode-region "~/elisp/uu" "" t)
;;(autoload 'uudecode-region-replace "~/elisp/uu" "" t)
;;(autoload 'uumerge-buffer "~/elisp/uu" "" t)
;;(autoload 'mark-next-uuencode "~/elisp/uu" "" t)


;; Options Menu Settings
;; =====================
(cond
 ((and (string-match "XEmacs" emacs-version)
       (boundp 'emacs-major-version)
       (or (and
            (= emacs-major-version 19)
            (>= emacs-minor-version 14))
           (= emacs-major-version 20))
       (fboundp 'load-options-file))
  (load-options-file "/home/tc/.xemacs-options")))
;; ============================
;; End of Options Menu Settings


(put 'narrow-to-region 'disabled nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                      Changing the Modeline                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Enable line numbers and column numbers.  This is done in C code now
;; and is very fast.
(line-number-mode 1)
(column-number-mode 1)

;; Rearrange the modeline so that everything is to the left of the
;; long list of minor modes, which is relatively unimportant but takes
;; up so much room that anything to the right is obliterated.

(setq-default
 modeline-format
 (list
  ""
  (if (boundp 'modeline-multibyte-status) 'modeline-multibyte-status "")
  (cons modeline-modified-extent 'modeline-modified)
  (cons modeline-buffer-id-extent
	(list (cons modeline-buffer-id-left-extent
		    (cons 15 (list
			      (list 'line-number-mode "L%l ")
			      (list 'column-number-mode "C%c ")
			      (cons -3 "%p"))))
	      (cons modeline-buffer-id-right-extent "%17b")))
  "   "
  'global-mode-string
  "   %[("
  (cons modeline-minor-mode-extent
	(list "" 'mode-name 'minor-mode-alist))
  (cons modeline-narrowed-extent "%n")
  'modeline-process
  ")%]----"
  "%-"
  ))


;; Get rid of modeline information taking up too much space -- in
;; particular, minor modes that are always enabled.
(setq pending-delete-modeline-string "")
(setq filladapt-mode-line-string "")
;; lazy-lock doesn't have a variable for its modeline name, so we have
;; to do a bit of surgery.
(and (assoc 'lazy-lock-mode minor-mode-alist)
     (setcdr (cdr (cadr (assoc 'lazy-lock-mode minor-mode-alist))) ""))
