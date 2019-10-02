function [tokenized,varargout] = tokenizeDocument2(tweets)

            stopwords_url = 'http://www.textfixer.com/resources/common-english-words.txt';
            stopWords = webread(stopwords_url);
            stopWords = textscan(stopWords,'%s','Delimiter',',');
            stopWords = stopWords{1}(:);   
            % iterate over tweets
            tokenized = cell(size(tweets.tweet));
            word_list = {};
            
            for i = 1:length(tweets.tweet)
                % lower case 
                tweet = strtrim(lower(tweets.tweet{i}));
                tweet =regexprep(tweet,'[a-zA-Z]+''nt','not');
                tweet =regexprep(tweet,'[a-zA-Z]+''s','');
                tweet =regexprep(tweet,'[a-zA-Z]+''ll','');
                tweet =regexprep(tweet,'[a-zA-Z]+''d','');
                tweet =regexprep(tweet,'[a-zA-Z]+n''t','not');
                tweet =regexprep(tweet,'[a-zA-Z]+''re','are');
                tweet =regexprep(tweet,'[a-zA-Z]+''m','am');
                tweet = regexprep(tweet,'(http|https)://[^\s]*','');
                tweet = regexprep(tweet,'(www).[^\s]*','');
                tweet = regexprep(tweet,'@[^\s]*','');
                tweet = regexprep(tweet,'#[^\s]*','');
                tweet = regexprep(tweet,'\<rt\>','');
                tweet = regexprep(tweet,'\<amp\>','');
                % remove numbers
                tweet = regexprep(tweet, '[0-9]+','');
                % remove URLs
                % check if tweet is still valids
                if ~isempty(tweet)
                        % tokenize the content - returns a nested cell array
                        tokens = textscan(tweet,'%s');
                        tokens = tokens{1}(:);
                        
                        tokens = regexprep(tokens, '[^Aa-zZ]+','');
                        tokens = regexprep(tokens, '\<gt\>','');
                        % remove unicode characters
                        tokens = regexprep(tokens,'\\u','');
                        % remove empty elements
                        tokens = tokens(~cellfun('isempty',tokens));
                        % remove stopwords 
                        tokens = tokens(~ismember(tokens, stopWords));
                        files = dir();
                        for k = 1:length(tokens)
                                try 
                                   tokens{k} = normalizeWords(strtrim(tokens{k}),'language','en','style','lemma'); 
                                catch
                                    tokens{k} = ''; 
                                    continue;
                                end
                        end
                        % remove one character words
                        tokens = tokens(cellfun('length',tokens) > 2);
                        % store tokens
                        tokenized{i,1} = tokens;
                        word_list = [word_list;tokens];
                end
            end
            varargout = {word_list};
        end