/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package common;

import org.json.JSONObject;

/**
 *
 * @author japf
 */
public interface IToJsonObject {
    public static final String TypeLabel = "GIT_type";
    JSONObject toJSONObject();
}
