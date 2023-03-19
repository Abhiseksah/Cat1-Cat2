trigger CPQ_Product on Product2 (after update) {
CPQ_TriggerDispatcher.Run(new CPQ_ProductTriggerHandler());
}