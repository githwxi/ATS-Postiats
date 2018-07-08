<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY html-ss
 SYSTEM "/usr/share/sgml/docbook/stylesheet/dsssl/modular/html/docbook.dsl" CDATA dsssl>
<!ENTITY print-ss
 SYSTEM "/usr/share/sgml/docbook/stylesheet/dsssl/modular/print/docbook.dsl" CDATA dsssl>
]>
    
<style-sheet>

<style-specification id="html" use="html-stylesheet">
<style-specification-body> 

;; html customization
;; (define nochunks #t)
(define %html-ext% ".html")
(define %stylesheet% "./assets/ATS2FPCRASH-BOOK.css")
    
</style-specification-body>
</style-specification>

<style-specification id="print" use="print-stylesheet">
<style-specification-body> 

;; customization for print

</style-specification-body>
</style-specification>

<external-specification id="html-stylesheet" document="html-ss">
<external-specification id="print-stylesheet" document="print-ss">

</style-sheet>
