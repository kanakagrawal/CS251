% resume.cls

% \documentstyle{resume}

% Inspired and drawn as an outline from Trey Hunner's distribution

\ProvidesClass{resume}[11/09/2016 v1 Resume class]

\LoadClass[11pt,letterpaper]{article}

\usepackage[parfill]{parskip} % Do not indent paragraphs
\usepackage{array} % required for boldface tabular columns
\usepackage{ifthen}
\usepackage{graphicx}

\nofiles % .aux files are not needed for resumes
\pagestyle{empty} % resumes do not need page numbers

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HEADINGS: Commands for printing name and address

\def \name#1{\def\@name{#1}} % \name command can be used to set name
\def \@name {} % Set \@name to empty by default

\def \addressSep {$\diamond$} % Set default address seperator

% One or two address lines can be specified
\let \@addressone \relax
\let \@addresstwo \relax

% \address command can be used to set first and second address (optional)
\def \address #1{
  \@ifundefined{@addresstwo}{
    \def \@addresstwo {#1}
  }{
    \def \@addressone {#1}
  }
}

% \printaddress is used to style an address line (given as input)
\def \printaddress #1{
  \begingroup
    \def \\ {\addressSep\ }
    \centerline{#1}
  \endgroup
  \par
  \addressskip
}

% \printname is used to print the name as a page header
\def \printname {
  \begingroup
    \hfil{\MakeUppercase{\namesize\bf \@name}}\hfil
    \nameskip\break
  \endgroup
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DOCUMENT: Create the head of the document

\let\ori@document=\document
\renewcommand{\document}{
  \ori@document % Begin document
  \printname % Print the name specified with \name
  \@ifundefined{@addressone}{}{ % Print the first address if specified
    \printaddress{\@addressone}}
  \@ifundefined{@addresstwo}{}{ % Print the second address if specified
    \printaddress{\@addresstwo}}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% start writing your environments and commands from here


\def\namesize{\huge}
\def\nameskip{\medskip}
\def\addressskip{\smallskip}
\def\sectionskip{\bigskip}
\def\sectionlineskip{\medskip}


\newenvironment{Header}[6]{
  \noindent\begin{minipage}{0.6\textwidth}
    \ifthenelse{\equal{#1}{}}{}{
      #1\\[0.2em]                                  %Name
    }
    \ifthenelse{\equal{#2}{}}{
      \ifthenelse{\equal{#3}{}}{}{
        #3nd Year\\[0.2em]
      }
    }{
      \ifthenelse{\equal{#3}{}}{
        #2\\[0.2em]
      }{
        #2 #3nd Year\\[0.2em]                      %Degree + Year
      }
    }
    \ifthenelse{\equal{#4}{}}{}{
      #4\\[0.2em]                                  %Address
    }
    \ifthenelse{\equal{#5}{}}{}{
      #5\\[0.2em]                                  %email
    }
  \end{minipage}
  \hfill
  \noindent\begin{minipage}{0.3\textwidth}
    \begin{flushright}  
      \includegraphics[width=3cm,height=3cm]{#6}
    \end{flushright}
  \end{minipage}
}
{
  \hfill\\\hrule
  \vspace{2em}

}

\renewenvironment{section}[1]{
  \hfill\newline
  \ifthenelse{\equal{#1}{}}{}{
    \textbf{\underline{\MakeUppercase{#1}}}\newline\\
  }
}
{
  \vspace{1em}
}

\renewenvironment{subsection}[4]{
  \ifthenelse{\equal{#1}{}}{
    \ifthenelse{\equal{#2}{}}{}{
      \hfill #2
    }
  }{
    \ifthenelse{\equal{#2}{}}{
      \textbf{#1}\\
  }{
      \textbf{#1}                   %Project Name
      \hfill #2 \\                   %duration
    }
  } 
  \ifthenelse{\equal{#3}{}}{
    \ifthenelse{\equal{#4}{}}{}{
      \hfill \textsf{#4}
    }
  }{
    \ifthenelse{\equal{#4}{}}{
      \textit{#3}\\
  }{
      \textit{#3}                   %Project Name
      \hfill \textsf{#4} \\                   %duration
    }
  }
  \begin{itemize}
  \vspace{-1.5em}
}
{
  \end{itemize}
}

\newcommand{\Quote}[2]{
  \ifthenelse{\equal{#1}{}}{}{
    \ifthenelse{\equal{#2}{}}{
      \begin{center}
        \Large\it{``#1"}\\
      \end{center}    
    }{
      \begin{center}
        \Large\it{``#1"}\\\hfill
        \small\textup{-#2}\\
      \end{center}
    }
  }
}

\newcommand{\hello}[1]{#1\hfill\newline}

\makeatletter
\newcommand\myfunc[1]{\@for\tmp:=#1\do{\func{\tmp}}}
\let\func\hello


\def\corecourselist{CORE COURSES, ,}
\newcommand{\noncorecourselist}{NON-CORE COURSES, ,}
\newcommand{\core}[1]{
  \xdef\corecourselist{\corecourselist,#1}
}
\newcommand{\noncore}[1]{
  \xdef\noncorecourselist{\noncorecourselist,#1} 
}
\newcommand{\allcore}[1]{
  \myfunc{#1}
}
\newcommand{\allnoncore}[1]{
  \myfunc{#1}
}

\newenvironment{Course}{}{
  \begin{minipage}[t]{0.5\textwidth}
    \begin{center}
      \allcore{\corecourselist}
    \end{center}
  \end{minipage}
  \begin{minipage}[t]{0.5\textwidth}
    \begin{center}
      \allnoncore{\noncorecourselist}
    \end{center}
  \end{minipage}
}