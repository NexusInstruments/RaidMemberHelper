local PackageName, Major, Minor, Patch = "RaidMemberHelper", 1, 0, 0
local PkgMajor, PkgMinor = PackageName, tonumber(string.format("%02d%02d%02d", Major, Minor, Patch))
local Pkg = Apollo.GetPackage(PkgMajor)
if Pkg and (Pkg.nVersion or 0) >= PkgMinor then
  return -- no upgrade needed
end

-- Set a reference to the actual package or create an empty table
local RaidMemberHelper = Pkg and Pkg.tPackage or {}

function RaidMemberHelper:GetMyGroupMember()
  local player = GameLib.GetPlayerUnit()
  if player then
    local playerUnitName = player:GetName()

    for i=1,GroupLib.GetMemberCount() do
      member = GroupLib.GetGroupMember(i)
      memberName = member.strCharacterName
      if playerUnitName == memberName then
        return i, member
      end
    end
  end
  return nil, nil
end

function RaidMemberHelper:GetMember(memberId)
  local member
  if memberId then
    member = GroupLib.GetGroupMember(memberId)
  else
    memberId, member = self:GetMyGroupMember()
  end
  return memberId, member
end


function RaidMemberHelper:GetMemberProperty(memberId, property)
  local member
  memberId, member = self:GetMember(memberId)

  if member then
    if member[property] then
      return member[property]
    end
  end

  return nil
end

function RaidMemberHelper:IsLeader(memberId)
  return self:GetMemberProperty(memberId, 'bIsLeader')
end

function RaidMemberHelper:IsMainTank(memberId)
  return self:GetMemberProperty(memberId, 'bMainTank')
end

function RaidMemberHelper:IsMainAssist(memberId)
  return self:GetMemberProperty(memberId, 'bMainAssist')
end

function RaidMemberHelper:IsRaidAssistant(memberId)
  return self:GetMemberProperty(memberId, 'bRaidAssistant')
end

function RaidMemberHelper:IsOnline(memberId)
  return self:GetMemberProperty(memberId, 'bIsOnline')
end

function RaidMemberHelper:IsDisconnected(memberId)
  return self:GetMemberProperty(memberId, 'bDisconnected')
end

function RaidMemberHelper:IsReady(memberId)
  return self:GetMemberProperty(memberId, 'bReady')
end

function RaidMemberHelper:IsTank(memberId)
  return self:GetMemberProperty(memberId, 'bTank')
end

function RaidMemberHelper:IsHealer(memberId)
  return self:GetMemberProperty(memberId, 'bHealer')
end

function RaidMemberHelper:IsDPS(memberId)
  return self:GetMemberProperty(memberId, 'bDPS')
end

function RaidMemberHelper:CanMark(memberId)
  return self:GetMemberProperty(memberId, 'bCanMark')
end

function RaidMemberHelper:CanInvite(memberId)
  return self:GetMemberProperty(memberId, 'bCanInvite')
end

function RaidMemberHelper:CanKick(memberId)
  return self:GetMemberProperty(memberId, 'bCanKick')
end

function RaidMemberHelper:IsRaidHelper(memberId)
  local id, member = self:GetMember(memberId)
  if member then
    return (member.bIsLeader or member.bMainTank or member.bMainAssist or member.bRaidAssistant)
  end
  return false
end

Apollo.RegisterPackage(RaidMemberHelper, PkgMajor, PkgMinor, {})
