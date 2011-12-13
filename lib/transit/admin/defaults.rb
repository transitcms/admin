# Transit::Delivery.manage(:audio) do |context, manager|
#   manager.deliver_context(context)
#   manager.form.text_field :source
# end
# 
# Transit::Delivery.manage(:text_block) do |context, manager|
#   manager.form.text_area :body
# end
# 
# Transit::Delivery.manage(:video) do |context, manager|
#   manager.deliver_context(context)
#   manager.form.text_field :source
# end