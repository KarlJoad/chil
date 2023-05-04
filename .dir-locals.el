;; Per-directory local variables for GNU Emacs 23 and later.

((nil . ((fill-column . 78)
         (sentence-end-double-space . t)

         ;; Emacs-Guix
         (eval . (setq-local guix-directory
                             (locate-dominating-file default-directory
                                                     ".dir-locals.el")))
         ;; Geiser
         ;; This allows automatically setting the `geiser-guile-load-path'
         ;; variable when using various Guix checkouts (e.g., via git worktrees).
         (eval . (let ((root-dir-unexpanded (locate-dominating-file
                                             default-directory ".dir-locals.el")))
                   ;; While Guix should in theory always have a .dir-locals.el
                   ;; (we are reading this file, after all) there seems to be a
                   ;; strange problem where this code "escapes" to some other buffers,
                   ;; at least vc-mode.  See:
                   ;;   https://lists.gnu.org/archive/html/guix-devel/2020-11/msg00296.html
                   ;; Upstream report: <https://bugs.gnu.org/44698>
                   ;; Hence the following "when", which might otherwise be unnecessary;
                   ;; it prevents causing an error when root-dir-unexpanded is nil.
                   (when root-dir-unexpanded
                     (let* ((root-dir (file-local-name (expand-file-name root-dir-unexpanded)))
                            ;; Workaround for bug https://issues.guix.gnu.org/43818.
                            (root-dir* (directory-file-name root-dir)))

                       (unless (boundp 'geiser-guile-load-path)
                         (defvar geiser-guile-load-path '()))
                       (make-local-variable 'geiser-guile-load-path)
                       (require 'cl-lib)
                       (cl-pushnew root-dir* geiser-guile-load-path
                                   :test #'string-equal)))))))
 (org-mode . ((org-edit-src-content-indentation 0)))
 (lisp-mode
  . ((eval . (cl-flet ((enhance-imenu-lisp
                        (&rest keywords)
                        (dolist (keyword keywords)
                          (let ((prefix (when (listp keyword) (cl-second keyword)))
                                (keyword (if (listp keyword)
                                             (cl-first keyword)
                                           keyword)))
                            (add-to-list
                             'lisp-imenu-generic-expression
                             (list (purecopy (concat (capitalize keyword)
                                                     (if (string= (substring-no-properties keyword -1) "s")
                                                         "es"
                                                       "s")))
                                   (purecopy (concat "^\\s-*("
                                                     (regexp-opt
                                                      (list (if prefix
                                                                (concat prefix "-" keyword)
                                                              keyword)
                                                            (concat prefix "-" keyword))
                                                      t)
                                                     "\\s-+\\(" lisp-mode-symbol-regexp "\\)"))
                                   2))))))
               ;; This adds the argument to the list of imenu known keywords.
               (enhance-imenu-lisp
                '("bookmarklet-command" "define")
                '("class" "define")
                '("command" "define")
                '("ffi-method" "define")
                '("ffi-generic" "define")
                '("function" "define")
                '("internal-page-command" "define")
                '("internal-page-command-global" "define")
                '("mode" "define")
                '("parenscript" "define")
                "defpsmacro")))))
 (scheme-mode
  .
  ((indent-tabs-mode . nil)
   (eval . (put 'eval-when 'scheme-indent-function 1))
   (eval . (put 'call-with-prompt 'scheme-indent-function 1))
   (eval . (put 'test-assert 'scheme-indent-function 1))
   (eval . (put 'test-assertm 'scheme-indent-function 2))
   (eval . (put 'test-equalm 'scheme-indent-function 1))
   (eval . (put 'test-equal 'scheme-indent-function 1))
   (eval . (put 'test-eq 'scheme-indent-function 1))
   (eval . (put 'call-with-input-string 'scheme-indent-function 1))
   (eval . (put 'call-with-port 'scheme-indent-function 1))
   (eval . (put 'guard 'scheme-indent-function 1))
   (eval . (put 'lambda* 'scheme-indent-function 1))
   (eval . (put 'substitute* 'scheme-indent-function 1))
   (eval . (put 'match-record 'scheme-indent-function 2))

   ;; TODO: Contribute these to Emacs' scheme-mode.
   (eval . (put 'let-keywords 'scheme-indent-function 3))

   ;; 'modify-inputs' and its keywords.
   (eval . (put 'modify-inputs 'scheme-indent-function 1))
   (eval . (put 'replace 'scheme-indent-function 1))

   ;; 'modify-phases' and its keywords.
   (eval . (put 'modify-phases 'scheme-indent-function 1))
   (eval . (put 'replace 'scheme-indent-function 1))
   (eval . (put 'add-before 'scheme-indent-function 2))
   (eval . (put 'add-after 'scheme-indent-function 2))

   (eval . (put 'modify-services 'scheme-indent-function 1))
   (eval . (put 'with-directory-excursion 'scheme-indent-function 1))))

 (emacs-lisp-mode . ((indent-tabs-mode . nil)))
 (texinfo-mode    . ((indent-tabs-mode . nil)
                     (fill-column . 72))))
