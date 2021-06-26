class SlackService < MessageService

    URL = "https://hooks.slack.com/services/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"

    def send(message)
        body = {:text => message }
        headers = { 'Content-Type' => 'application/json' }
        response = HTTParty.post(URL, :body => body.to_json, :headers => headers)
        if (response.code != 200)
            puts ("Something wrong happened trying to deliver [message:" + message + "] [code:" + response.code.to_s + "] [message:" + response.message + "]")
        end
    end

end
