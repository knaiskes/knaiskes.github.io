;; Load the publishing system
(require 'ox-publish)

(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

(defvar site-head
  (concat
   "<meta charset=\"utf-8\">"
   "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
   "<link rel=\"stylesheet\" type=\"text/css\" href=\"static/css/style.css\">"))

(defvar my-preamble
  (concat
   "<nav class=\"navbar\">"
     "<a href=\"index.html\">Home</a>"
     "<a href=\"posts.html\">Posts</a>"
     "<a href=\"contact.html\">Contact</a>"
     "</nav>"
     "<div id=\"content\">"))

(defvar my-postamble
  (concat
   "<div id=\"postamble\">"
   "Build with GNU/Emacs :)\n"
   "</div>"))

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "org-site:main"
             :recursive t
             :base-directory "./content"
             :publishing-function 'org-html-publish-to-html
             :publishing-directory "./public"
             :with-author nil           ;; Don't include author name
             :with-creator t            ;; Include Emacs and Org versions in footer
             :with-toc nil                ;; Include a table of contents
             :section-numbers nil       ;; Don't include section numbers
             :time-stamp-file nil)
	     ;;sitemap
	     ;;:auto-sitemap t
	     ;;:sitemap-filename "posts.org"
	     ;;:sitemap-style list
	     ;;:sitemap-title "Posts"
	     ;;:sitemap-sort-files 'anti-chronologically)
       (list "org-static"
	    :base-directory "./"
	    :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
	    :publishing-directory "./public/"
	    :recursive t
	    :publishing-function 'org-publish-attachment
	    )))

;; Customize the HTML output
(setq org-html-preamble  my-preamble
      org-html-postamble my-postamble
      org-html-metadata-timestamp-format "%d-%m-%Y"
      org-html-html5-fancy nil
      org-html-htmlize-output-type 'css
      org-html-self-link-headlines t
      org-html-validation-link nil
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head site-head
      org-html-doctype "html5")

;; Generate the site output
(org-publish-all t)

(message "Build complete!")
