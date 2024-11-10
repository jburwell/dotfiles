;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "John Burwell"
      user-mail-address "jburwell@deloitte.com")
(setq datetime-timezone #'US/Eastern)

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Hack Nerd Font" :size 16))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org")
(setq org-roam-directory "~/Documents/org/roam")

(after! org-fancy-priorities
  (setq org-fancy-priorities-list '("↑" "←" "↓")))

(after! org
  (setq calendar-week-start-day 1)
  (setq org-log-done 'time)
  (setq org-log-into-drawer "LOGBOOK")
  ;; More intuitive link opening
  (map! :leader
        (
         :prefix-map ("l" . "link")
         :desc "Open link at cursor" "o" #'org-open-at-point
         )
        )

  (setq org-archive-location ".archive/%s_archive::")
  ;; Jump back-forth between visible headers
  (map! :leader
        (:desc "Next visible heading" "]" #'outline-next-visible-heading)
        )
  (map! :leader
        (:desc "Previous visible heading" "[" #'outline-previous-visible-heading)
        )
  (setq org-download-method 'directory)
  (setq org-download-image-dir "images")
  (setq org-download-heading-lvl nil)
  (setq org-download-timestamp "%Y%m%d-%H%M%S_")
  (setq org-image-actual-width 300)
  (map! :leader
        :prefix-map ("v" . "paste")
        (:desc "Paste image from clipboard" "i" #'zz/org-download-paste-clipboard))
  (add-to-list 'org-modules 'org-habit)
  (set 'org-habit-show-all-today t)
(setq org-capture-templates
      `(("t" "Task" entry (file "inbox.org")
         ,(string-join '("* TODO %?"
                         ":PROPERTIES:"
                         ":CREATED: %U"
                         ":END:")
                       "\n"))
       ("n" "Note" entry (file "inbox.org")
         ,(string-join '("* %?"
                         ":PROPERTIES:"
                         ":CREATED: %U"
                         ":END:")
                       "\n"))
        ("m" "Meeting" entry (file "inbox.org")
         ,(string-join '("* %? :meeting:"
                         "<%<%Y-%m-%d %a %H:00>>"
                         ""
                         "/Met with: /")
                       "\n"))
        ("a" "Appointment" entry (file "inbox.org")
         ,(string-join '("* %? :appointment:"
                         ":PROPERTIES:"
                         ":CREATED: %U"
                         ":END:")
                       "\n"))
        ))
(setq org-todo-keywords
      '((sequence "TODO(t)" "STRT(s)" "HOLD(h)" "|" "DONE(d)" "CNCL(c)")))
(setq org-todo-keyword-faces '(("STRT" . +org-todo-active)
                               ("HOLD" . +org-todo-onhold)
                               ("CNCL" . +org-todo-cancel)))
(setq org-agenda-custom-commands
      '(("g" "Get Things Done (GTD)"
         ;; Only show entries with the tag "inbox" -- just in case some entry outside inbox.org still has that file
         ((tags "inbox"
                ((org-agenda-prefix-format "  %?-12t% s")
                 ;; The list of items is already filtered by this tag, no point in showing that it exists
                 (org-agenda-hide-tags-regexp "inbox")
                 ;; The header of this section should be "Inbox: clarify and organize"
                 (org-agenda-overriding-header "\nInbox: clarify and organize\n")))))))
(add-to-list 'org-capture-templates
             `("t" "Task" entry (file "inbox.org")
               ,(string-join '("* TODO %?"
                               ":PROPERTIES:"
                               ":CREATED: %U"
                               ":END:"
                               "/Context:/ %a")
                             "\n"
                             )))
(add-to-list 'org-capture-templates
             `("n" "Note" entry (file "inbox.org")
               ,(string-join '("* %?"
                               ":PROPERTIES:"
                               ":CREATED: %U"
                               ":END:"
                               "/Context:/ %a")
                             "\n")))
(setq org-refile-contexts
      '((((("inbox.org") . (:regexp . "Projects"))) ;; example
         ((lambda () (string= (org-find-top-headline) "Inbox")))
         )
        ;; 6: Notes without a project go to notes.org
        (((("inbox.org") . (:regexp . "Notes")))
         ;;((lambda () (string= (org-element-property :my_type (org-element-at-point)) "NOTE")))
         ((lambda () ('regexp ":my_type:")))
         )
        ))
(setq org-agenda-files (list "inbox.org" "agenda.org"
                             "notes.org" "projects.org"))
(setq org-agenda-custom-commands
      '(("g" "Get Things Done (GTD)"
         ;; Only show entries with the tag "inbox" -- just in case some entry outside inbox.org still has that file
         ((tags "inbox"
                ((org-agenda-prefix-format "  %?-12t% s")
                 ;; The header of this section should be "Inbox: clarify and organize"
                 (org-agenda-overriding-header "\nInbox: clarify and organize\n")))
          ;; Show tasks that can be started and their estimates, do not show inbox
          (todo "TODO"
                ((org-agenda-skip-function
                  '(org-agenda-skip-entry-if 'deadline 'scheduled))
                 (org-agenda-files (list "agenda.org" "notes.org" "projects.org"))
                 (org-agenda-prefix-format "  %i %-12:c [%e] ")
                 (org-agenda-max-entries 5)
                 (org-agenda-overriding-header "\nTasks: Can be done\n")))
          ;; Show agenda around today
          (agenda nil
                  ((org-scheduled-past-days 0)
                   (org-deadline-warning-days 0)))
          ;; Show tasks on hold
          (todo "HOLD"
                ((org-agenda-prefix-format "  %i %-12:c [%e] ")
                 (org-agenda-overriding-header "\nTasks: on hold\n")))
          ;; Show tasks that are in progress
          (todo "STRT"
                ((org-agenda-prefix-format "  %i %-12:c [%e] ")
                 (org-agenda-overriding-header "\nTasks: in progress\n")))

          ;; Show tasks that I completed today
          (tags "CLOSED>=\"<today>\""
                ((org-agenda-overriding-header "\nCompleted today\n"))))
         (
          ;; The list of items is already filtered by this tag, no point in showing that it exists
          (org-agenda-hide-tags-regexp "inbox")))
        ("G" "All tasks that can be done"
         ((todo "TODO"
                ((org-agenda-skip-function
                  '(org-agenda-skip-entry-if 'deadline 'scheduled))
                 (org-agenda-files (list "agenda.org" "notes.org" "projects.org")) (org-agenda-prefix-format "  %i %-12:c [%e] ")
                 (org-agenda-overriding-header "\nTasks: Can be done\n")))
          (agenda nil
                  ((org-scheduled-past-days 0)
                   (org-deadline-warning-days 0)))))))
(setq org-agenda-time-grid
  '((daily today require-timed remove-match)
    (800 1000 1200 1400 1600 1800 2000)
    "......"
    "----------------"))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
