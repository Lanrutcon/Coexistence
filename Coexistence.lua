local BlizzFunction = TextStatusBar_UpdateTextStringWithValues;


--Creating FontStrings
local frame = PlayerFrameHealthBarText:GetParent();
PlayerFrameHealthBar.LeftText = frame:CreateFontString(nil, "BACKGROUND", "TextStatusBarText");
PlayerFrameHealthBar.LeftText:SetPoint("LEFT", 110, 3);
PlayerFrameHealthBar.RightText = frame:CreateFontString(nil, "BACKGROUND", "TextStatusBarText");
PlayerFrameHealthBar.RightText:SetPoint("RIGHT", -8, 3);
PlayerFrameManaBar.LeftText = frame:CreateFontString(nil, "BACKGROUND", "TextStatusBarText");
PlayerFrameManaBar.LeftText:SetPoint("LEFT", 110, -8);
PlayerFrameManaBar.RightText = frame:CreateFontString(nil, "BACKGROUND", "TextStatusBarText");
PlayerFrameManaBar.RightText:SetPoint("RIGHT", -8, -8);

frame = TargetFrameTextureFrameHealthBarText:GetParent();
TargetFrameHealthBar.RightText = frame:CreateFontString(nil, "BACKGROUND", "TextStatusBarText");
TargetFrameHealthBar.RightText:SetPoint("LEFT", 8, 3);
TargetFrameHealthBar.LeftText = frame:CreateFontString(nil, "BACKGROUND", "TextStatusBarText");
TargetFrameHealthBar.LeftText:SetPoint("RIGHT", -110, 3);
TargetFrameManaBar.RightText = frame:CreateFontString(nil, "BACKGROUND", "TextStatusBarText");
TargetFrameManaBar.RightText:SetPoint("LEFT", 8, -8);
TargetFrameManaBar.LeftText = frame:CreateFontString(nil, "BACKGROUND", "TextStatusBarText");
TargetFrameManaBar.LeftText:SetPoint("RIGHT", -110, -8);

frame = FocusFrameTextureFrameHealthBarText:GetParent();
FocusFrameHealthBar.RightText = frame:CreateFontString(nil, "BACKGROUND", "TextStatusBarText");
FocusFrameHealthBar.RightText:SetPoint("LEFT", 8, 3);
FocusFrameHealthBar.LeftText = frame:CreateFontString(nil, "BACKGROUND", "TextStatusBarText");
FocusFrameHealthBar.LeftText:SetPoint("RIGHT", -110, 3);
FocusFrameManaBar.RightText = frame:CreateFontString(nil, "BACKGROUND", "TextStatusBarText");
FocusFrameManaBar.RightText:SetPoint("LEFT", 8, -8);
FocusFrameManaBar.LeftText = frame:CreateFontString(nil, "BACKGROUND", "TextStatusBarText");
FocusFrameManaBar.LeftText:SetPoint("RIGHT", -110, -8);



function TextStatusBar_UpdateTextStringWithValues(statusFrame, textString, value, valueMin, valueMax)
	if( statusFrame.LeftText and statusFrame.RightText ) then
		statusFrame.LeftText:SetText("");
		statusFrame.RightText:SetText("");
		statusFrame.LeftText:Hide();
		statusFrame.RightText:Hide();
	end
	
	if ( ( tonumber(valueMax) ~= valueMax or valueMax > 0 ) and not ( statusFrame.pauseUpdates ) ) then
		statusFrame:Show();

		if ( (statusFrame.cvar and GetCVar(statusFrame.cvar) == "1" and statusFrame.textLockable) or statusFrame.forceShow ) then
			textString:Show();
		elseif ( statusFrame.lockShow > 0 and (not statusFrame.forceHideText) ) then
			textString:Show();
		else
			textString:SetText("");
			textString:Hide();
			return;
		end

		local valueDisplay = value;
		local valueMaxDisplay = valueMax;
		local smallNum;
		if (valueDisplay > 10000) then
			valueDisplay = math.floor(valueDisplay/1000 + 0.5);
			valueMaxDisplay = math.floor(valueMaxDisplay/1000 + 0.5);
			smallNum = false;
		else
			smallNum = true;
		end

		if ( value and valueMax > 0 ) then
			if( statusFrame.LeftText and statusFrame.RightText ) then
				if(not statusFrame.powerToken or statusFrame.powerToken == "MANA") then
					statusFrame.LeftText:SetText(math.ceil((value / valueMax) * 100) .. "%");
					statusFrame.LeftText:Show();
				end
				if(not smallNum) then
					statusFrame.RightText:SetText(valueDisplay.."k");
				else
					statusFrame.RightText:SetText(valueDisplay);
				end
				statusFrame.RightText:Show();
				textString:Hide();
			else
				--anything besides player, target and focus will have: currentHP/MaxHP
				valueDisplay = valueDisplay .. " / " .. valueMaxDisplay;
			end
			textString:SetText(valueDisplay);
		elseif ( value == 0 and statusFrame.zeroText ) then
			textString:SetText(statusFrame.zeroText);
			statusFrame.isZero = 1;
			textString:Show();
			return;
		else
			statusFrame.isZero = nil;
			if ( statusFrame.prefix and (statusFrame.alwaysPrefix or not (statusFrame.cvar and GetCVar(statusFrame.cvar) == "1" and statusFrame.textLockable) ) ) then
				textString:SetText(statusFrame.prefix.." "..valueDisplay.." / "..valueMaxDisplay);
			else
				textString:SetText(valueDisplay.." / "..valueMaxDisplay);
			end
		end
	else
		textString:Hide();
		textString:SetText("");
		if ( not statusFrame.alwaysShow ) then
			statusFrame:Hide();
		else
			statusFrame:SetValue(0);
		end
	end
end