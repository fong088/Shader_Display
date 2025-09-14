Shader "ACG/Normal_Shader"
{
    Properties
    {
        _MainTex ("Albedo", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
        _BumpMap ("Normal Map", 2D) = "bump" {}
        _BumpScale ("Normal Scale", Float) = 1.0
    }

    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
        fixed4 _Color;
        sampler2D _BumpMap;
        float _BumpScale;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_BumpMap;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            
            fixed4 tex = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = tex.rgb;
            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap)) * _BumpScale;

            o.Alpha = tex.a;
        }
        ENDCG
    }
}
