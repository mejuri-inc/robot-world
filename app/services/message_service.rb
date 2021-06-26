class MessageService

    def send(message)
        raise NoMethodError, "#{self.class} #send is abstract and must be implemened in the subclass"
    end

end