desc 'generate all the available smart lists'
namespace :spree_marketing do
  namespace :smart_list do
    task generate: :environment do |_t, _args|
      ExceptionNotifier.notify_exception(StandardError.new('List generation started'))
      Spree::Marketing::List.generate_all
    end
  end
end
