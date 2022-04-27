function prune
    for branch in (git br)
        set withoutStar (string replace * '' branch) 
        set str (string trim $branch)
        
        echo branch: $withoutStar     
    end
end