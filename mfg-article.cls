% JLREQクラスを用いたArticleのスタイルファイル
% 2022/06/28
%
% jlreq.clsに改造を施し，自分好みのスタイルに変更する．
% クラスファイルはjlreqを用いることを前提として設計されている．
% そのほかのクラスファイル（例えば，jsarticle）では動作しない．
\NeedsTeXFormat{LaTeX2e}[2022/01/01]
\ProvidesClass{mfg-article}[2022/06/29 the MFG article package developed by yteshima]

\LoadClassWithOptions{jlreq}

\RequirePackage{tikz}
\RequirePackage[unicode=true]{hyperref}
\RequirePackage{amsmath, amssymb, physics}
\RequirePackage{unicode-math}
\RequirePackage[framemethod=tikz]{mdframed}
\RequirePackage[ipaex]{luatexja-preset}
\RequirePackage[explicit]{titlesec}

\newif\if@yteshi@migu
\@yteshi@migufalse
\DeclareOption{migu}{\@yteshi@migutrue}
\DeclareOption{nomigu}{\@yteshi@migufalse}
\ProcessOptions\relax

\setmainfont{Libertinus Serif}
\setsansfont{Libertinus Sans}
\setmathfont{Libertinus Math}
\if@yteshi@migu
	\setmonofont[
		Extension = .ttf,
		BoldFont  = migu-1m-bold
	]{migu-1m-regular}
	\setmonojfont[
		Extension = .ttf,
		BoldFont  = migu-1m-bold
	]{migu-1m-regular}
\else\fi

% 紙面の寸法の変更
\setlength{\topmargin}{\z@}
\setlength{\headheight}{10pt}
\setlength{\headsep}{10pt}
\setlength{\textheight}{658pt}

\renewcommand{\today}{\the\year/\the\month/\the\day}

\if@titlepage
\else
	\renewcommand{\@maketitle}{%
		\null%
		\vskip-\baselineskip% \nullで作ってしまった空白をなくす
		\vskip-\headsep% \headsep + \headheightの高さ分だけ上にシフトさせる
		\vskip-\headheight%
		\noindent\hrulefill\par% 横線
		\vskip0.5\baselineskip%
		\begingroup\centering
		\setmainjfont[
			Extension = .ttf,
			BoldFont  = GenJyuuGothic-P-Heavy
		]{GenJyuuGothic-P-Medium}%
		\setmainfont[
			Extension = .ttf,
			BoldFont  = GenJyuuGothic-P-Heavy
		]{GenJyuuGothic-P-Medium}
		{
			\jlreq@keepbaselineskip{\LARGE}\@title
		}%
		\par\vskip0.3\baselineskip
		{
			\jlreq@keepbaselineskip{\small}
			\ifx\@date\@empty%
				\vphantom{\@date}%
			\else
				\sffamily\@date%		
			\fi%
		}%
		\par\vskip0.3\baselineskip
		{
			\jlreq@keepbaselineskip{\large}
			\begin{tabular}[t]{c}
				\@author
			\end{tabular}
		}
		\par
		\endgroup
		\noindent\hrulefill% 横線
		\ifvoid\jlreq@abstractbox\else\unvbox\jlreq@abstractbox\fi%
	}
\fi

%% Section
\titleformat{\section}[block]
{% 書式
	\setmainjfont[
		Extension = .ttf,
		BoldFont  = GenJyuuGothic-P-Heavy
	]{GenJyuuGothic-P-Medium}%
	\setmainfont[
		Extension = .ttf,
		BoldFont  = GenJyuuGothic-P-Heavy
	]{GenJyuuGothic-P-Medium}%
	\jlreq@keepbaselineskip{\Large}%
}{% ラベル書式
	\thesection%
	\hskip0.5em%
	\begin{tikzpicture}[overlay]
		%\draw (0, -0.4\baselineskip) rectangle +(0.815\baselineskip, 1.5\baselineskip); % にゃんこのフレーム（デバッグ用）
		\node[inner sep=\z@, anchor=south west] (cat) at (0, -0.4\baselineskip)
		{\includegraphics[height=1.5\baselineskip]{fatcat.pdf}};
	\end{tikzpicture}
}{% ラベルと見出し文字列の間の空き
	\baselineskip%
}{% 見出しの直前に入るコード
	#1%
}
%[% 見出しの直後に入るコード
%{\addvspace{0.4ex}\titlerule[2pt]}%
%]
\titlespacing{\section}{0pt}{1\baselineskip plus .3\baselineskip minus .06\baselineskip}{1\baselineskip plus .1\baselineskip}

%% Subsection
\titleformat{\subsection}[block]
{% 書式
	\setmainjfont[
		Extension = .ttf,
		BoldFont  = GenJyuuGothic-P-Heavy
	]{GenJyuuGothic-P-Medium}%
	\setmainfont[
		Extension = .ttf,
		BoldFont  = GenJyuuGothic-P-Heavy
	]{GenJyuuGothic-P-Medium}%
	\jlreq@keepbaselineskip{\normalsize}%
}{% ラベル書式
	\rule[-0.5\baselineskip]{1ex}{1.5\baselineskip}%
	\hskip1ex
	\thesubsection%
}{% ラベルと見出し文字列の間の空き
	0.5em%
}{% 見出しの直前に入るコード
	#1%
}
\titlespacing{\subsection}{0pt}{.7\baselineskip plus .21\baselineskip minus .042\baselineskip}{.7\baselineskip plus .07\baselineskip}