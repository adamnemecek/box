import Foundation

class MGridVisorTake
{
    private weak var controller:CGridVisorTake?
    private weak var model:MGridAlgoItemAid!
    private let kDifficultyStats:UInt32 = 80
    
    init(controller:CGridVisorTake, model:MGridAlgoItemAid)
    {
        self.controller = controller
        self.model = model
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.strategyTake()
        }
    }
    
    //MARK: private
    
    private func strategyTake()
    {
        let random:UInt32 = arc4random_uniform(kDifficultyStats)
        let strategy:MGridVisorTakeProtocol
        
        if random == 0
        {
            strategy = MGridVisorTakeStats.factory()
        }
        else
        {
            strategy = MGridVisorTakeEnergy.factory()
        }
        
        guard
            
            let controller:CGridVisorTake = self.controller
        
        else
        {
            return
        }
        
        strategy.apply(controller:controller)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.controller?.viewTake.aidDefined(model:strategy)
        }
    }
}
