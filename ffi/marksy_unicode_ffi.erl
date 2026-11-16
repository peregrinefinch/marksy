%% SPDX-License-Identifier: Apache-2.0

%% The parser owns Markdown. These three operations only borrow the runtime's
%% Unicode tables, so a Greek letter and an ASCII letter get the same courtesy.
-module(marksy_unicode_ffi).
-export([punctuation/1, whitespace/1, casefold/1]).

punctuation(Text) ->
    re:run(Text, <<"^[\\p{P}\\p{S}]$">>, [unicode, {capture, none}]) =:= match.

whitespace(Text) ->
    re:run(Text, <<"^[\\p{Zs}\\t\\n\\f\\r]$">>, [unicode, {capture, none}]) =:= match.

casefold(Text) ->
    unicode:characters_to_binary(string:casefold(Text)).
